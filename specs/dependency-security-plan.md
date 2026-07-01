# Dependency security for simt-myenergy-app

## Status (2026-06-30)

Draft — recommendation-only. No implementation in this document. Decision
needed on whether to start with Dependabot (path of least resistance) or
go straight to a Renovate-based setup, and on whether to publish SBOMs
to GitHub Releases or an internal Dependency-Track.

## Goal

Add dependency vulnerability scanning, a software bill of materials
(SBOM), and automated dependency update PRs to the `simt-myenergy-app`
Flutter web app (deployed to Fly.io, CI on GitHub Actions). Today none
of these exist. The app ships a Docker image based on `nginx:alpine`
plus a Flutter web build, and pulls ~81 direct deps (~160 entries in
`app/pubspec.lock` including transitives) — real surface area, no
scanning.

Why this matters:

- A Flutter `pub` dep with a known CVE has no in-Pub equivalent of
  `npm audit`. We need an external scanner that reads `pubspec.lock`.
- The deployed image contains the Flutter engine, Dart SDK output, and
  the `nginx:alpine` base — neither `pubspec.yaml` nor the Dockerfile
  alone describes the full supply chain.
- Without bot scanning, version bumps only happen when a developer
  manually edits `pubspec.yaml`, which is essentially never for
  security-only updates.

## What's already in place

| Surface | State |
|---|---|
| `app/pubspec.lock` (~160 entries, pinned versions + sha256) | committed |
| `app/pubspec.yaml` (~81 direct deps, semver `^` ranges) | committed |
| Repository visibility | **public** (`cepro/simt-myenergy-app`) |
| `Dockerfile` (`FROM nginx:alpine`, not pinned to digest) | committed |
| `.github/workflows/build.yml` (CI: `bin/build-fly hmce` on every push) | live, no test step, no audit step |
| `.github/workflows/deploy.yml` + `deploy-template.yml` (Fly deploy on `*-wlce` / `*-hmce` tag) | live |
| GitHub Actions pinned to **major tag** (`@v6`, `@v2`, `@1.6`, `@v7`) | live, not SHA-pinned |
| Dependabot / Renovate config | **none** |
| OSV / Trivy / Snyk / Grype in CI | **none** |
| SBOM generation | **none** |
| GitHub Security tab → Dependabot alerts | off (no Dependabot config) |
| `bin/upload-sourcemaps-to-sentry` | unrelated (Sentry source maps) |

## Recommended stack

Three layers, each independent and additive:

1. **Bot for updates** — Dependabot (`pub` + `docker` + `github-actions`).
   Alternative: Renovate if we want richer grouping / auto-merge / a
   dashboard.
2. **CI scanning** — `osv-scanner` on `app/pubspec.lock` in `build.yml`
   and on the built image in `deploy-template.yml` (Dart deps vs. nginx +
   Alpine OS packages). Pairs with `actions/dependency-review-action` on
   PRs to block regressions.
3. **SBOM** — `syft` is the single tool for both surfaces: `syft dir:app`
   for the Dart app (reads `pubspec.yaml`/`pubspec.lock`) and
   `syft <image>` (or `trivy image`) for the Docker image. Both emit
   CycloneDX and SPDX. `cyclonedx-dart` is the alternative if you want a
   Dart-native generator; syft halves the SBOM tooling. Note: the deploy
   workflow currently creates **no** GitHub Release — see Phase 4.

### Why these specific tools

| Tool | Why this one |
|---|---|
| Dependabot | Native GitHub integration; auto-enables security alerts; first-class `pub` support since 2024; zero cost (and free on public repos). |
| `osv-scanner` (`google/osv-scanner-action`) | One tool, three surfaces: reads `pubspec.lock`, scans the built **image** (`osv-scanner scan image`), and ingests **SBOMs**; emits SARIF for Code Scanning; free. |
| `syft` (`anchore/sbom-action`) | Generates SBOMs (CycloneDX + SPDX) from **both** the app source and the image — one tool instead of two. (osv-scanner can scan a syft SBOM directly.) |
| `trivy image` (`aquasecurity/trivy-action`) | Optional: scans the image with the same tool that generated its SBOM. Redundant once you have syft + osv-scanner; keep only if you prefer it. |
| `cyclonedx-dart` | Alternative app-SBOM generator, Dart-native. Skipped in favor of syft unless you need its specific output. |
| `dependency-review-action` | Diff-only: blocks PRs that **introduce** new vulns of chosen severity (regression prevention). Does NOT catch vulns in unchanged deps — that's osv-scanner + Dependabot alerts. |

## Phased adoption (least → most effort)

### Phase 1 — Dependabot config (~10 min)

Add `.github/dependabot.yml` with:

- `package-ecosystem: pub`, `directory: /app`, weekly, group minor + patch
- `package-ecosystem: docker`, `directory: /`, weekly
- `package-ecosystem: github-actions`, `directory: /`, weekly

Group the version-coupled Supabase family (`supabase`, `supabase_flutter`,
`gotrue`, `realtime_client`, `storage_client`, `functions_client`) into a
single `groups:` block so Dependabot never opens a partial bump that
breaks their compatibility:

```yaml
# under the pub ecosystem config
groups:
  supabase:
    patterns:
      - "supabase"
      - "supabase_flutter"
      - "gotrue"
      - "realtime_client"
      - "storage_client"
      - "functions_client"
```

Enables the GitHub dependency graph and free security alerts as a side
effect (both free and automatic on a **public** repo).

### Phase 2 — CI vulnerability scan (~20 min)

Split the scan by surface so each workflow does the cheap, relevant
check — no duplication:

- **`build.yml`** — `osv-scanner` on `app/pubspec.lock` (Dart deps only,
  runs on every push/PR). Fail on `HIGH`/`CRITICAL` only; upload SARIF
  via `github/codeql-action/upload-sarif`.
- **`deploy-template.yml`** — `osv-scanner scan image` (or `trivy image`)
  on the built `myenergy:<tag>` image. This is the only place that
  catches `nginx:alpine` + Alpine OS-package vulns — the surface
  `pubspec.lock` cannot see. Fail `HIGH`/`CRITICAL`.

Add explicit `permissions:` blocks to both: SARIF upload needs
`security-events: write`; scanning needs `contents: read`. Neither
workflow has these today (`build.yml` has no `permissions:` block at all).

### Phase 3 — PR gate (~15 min)

Add `actions/dependency-review-action@v4` to a new PR-triggered
workflow (or extend `build.yml` to also run on
`pull_request: { branches: [main] }`). Fails when changed deps add a
vuln above the chosen severity.

Three notes:

- **Yes, add the `pull_request` trigger.** It's what lets the Phase 2
  osv step also scan Dependabot's own bump PRs — the two are coupled,
  not independent.
- **`dependency-review-action` only diffs the PR**, so it catches
  regressions but not a vuln in an unchanged dep. That full sweep is
  osv-scanner + Dependabot alerts. They're complementary, not
  substitutes.
- Needs `permissions: { contents: read, pull-requests: write }`.

### Phase 4 — SBOM generation (~30–45 min)

- `syft dir:app -o cyclonedx-json` step in `build.yml` → produces
  `app.cdx.json` for the Dart deps. Upload as a workflow artifact.
- `syft myenergy:<tag> -o spdx-json` (or `trivy image --format spdx-json`)
  on the built image in `deploy-template.yml` → produces `image.spdx.json`
  covering nginx + Alpine OS packages + the Dart runtime. Upload.
- **No GitHub Release exists today** — `deploy.yml`/`deploy-template.yml`
  only deploy to Fly and bump the build number. To attach SBOMs to a
  release you must first add a release step: create a GitHub Release from
  the `*-hmce`/`*-wlce` tag (e.g. `softprops/action-gh-release`), then
  attach both SBOMs as release assets. Alternatively, skip the release
  and keep both SBOMs as workflow artifacts. If/when an internal
  Dependency-Track exists, push there too — out of scope here.

### Phase 5 — Pin GitHub Actions + Dockerfile base to SHA (~20 min)

Defense in depth, complements bot scanning. One-off change:

- `actions/checkout@v6` → `@<sha> # v6`
- `subosito/flutter-action@v2` → SHA-pinned
- `superfly/flyctl-actions/setup-flyctl@1.6` → SHA-pinned
- `stefanzweifel/git-auto-commit-action@v7` → SHA-pinned
- `FROM nginx:alpine` → `FROM nginx:1.31.2-alpine3.23@sha256:54f2a904…`
  (the version `nginx:alpine` currently tracks — **not** the stale
  `1.27-alpine` from the original draft, which would have downgraded
  nginx; pin to the exact current version to avoid a downgrade, plus
  digest). Dependabot's `docker` ecosystem keeps the digest/version
  fresh automatically — no `versioning-strategy` needed.

This adds ~zero ongoing maintenance: once you SHA-pin *and* configure
`package-ecosystem: github-actions` + `docker`, Dependabot opens PRs
that bump the pinned SHA **and** keep the `# v6` comment / image digest
current automatically. Higher priority than the phase number suggests
on a **public** repo, where your CI supply chain is visible to anyone.

## Open questions / decisions

1. **Dependabot vs Renovate.** Dependabot is the cheaper default. If
   we want cross-ecosystem grouping (pub + docker + actions in one PR),
   auto-merge, or a central dashboard, Renovate earns its setup cost.
   Recommendation: start with Dependabot, migrate only if the noise
   becomes unmanageable.
2. **Severity thresholds.** `osv-scanner` and `dependency-review-action`
   both take a severity filter. `HIGH`/`CRITICAL` blocks CI; `MODERATE`
   warns in PR. Need a call on where to draw the line.
3. **SBOM destination.** GitHub Releases is free and visible (and the
   repo is public, so the dependency graph, `dependency-review-action`,
   SARIF/Code Scanning, and Dependabot alerts all work free out of the
   box). Note the deploy workflow currently creates no release — see
   Phase 4. If we later stand up Dependency-Track (or want to feed into
   Fly's image scanning), plan to mirror both.
4. **Build workflow triggers.** `build.yml` currently runs on every
   push to `main`. **Resolved: yes, add a `pull_request` trigger.** It's
   what lets the osv step also scan Dependabot's own bump PRs, and on a
   public repo Actions minutes are free anyway, so the cost objection
   doesn't apply.
5. **Flutter web asset supply chain.** CycloneDX-from-pubspec captures
   Dart deps but not the Flutter engine, Dart SDK, or `nginx:alpine`
   packages. Image-level SBOM (Trivy/Syft) covers those. Need both.
6. **Supabase + gotrue / realtime / storage / functions client libs.**
   These six Supabase packages are direct deps and the auth + data plane.
   Folded into Phase 1: a Dependabot `groups:` block bundles the whole
   family into one PR so a bump never lands piecemeal. Consider also
   triaging Supabase vulns at `critical` severity in the Phase 2
   threshold.

## What this plan deliberately does *not* recommend

- Replacing `bin/build-fly` or the tag-based deploy workflow.
- Touching the nginx config or the existing Sentry release flow.
- Migrating to Renovate without first trying Dependabot.
- Standing up a separate vulnerability dashboard — GitHub's Security
  tab is enough for now.
- Changing `dependency_overrides` in `pubspec.yaml` — those are there
  to keep the Flutter SDK happy and unrelated to this work.