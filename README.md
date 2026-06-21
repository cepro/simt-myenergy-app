# Simtricity MyEnergy App

This repo holds the code for the MyEnergy app and the scripts to build it.

See the repositories [simt-myenergy-gh-pages-qa](https://github.com/cepro/simt-myenergy-gh-pages-qa) and [simt-myenergy-gh-pages-prod](https://github.com/cepro/simt-myenergy-gh-pages-prod). Build code is pushed to there and deployed to github pages which is where the app gets hosted.

## Install Tools

Install the Flutter SDK from the official tarball. We use the same source as
our GitHub Actions CI (`subosito/flutter-action@v2`) — no version manager
needed. The install script is at `~/bin/install-flutter`.

```sh
# One-time: install the SDK to the version pinned in .flutter-version
install-flutter "$(cat .flutter-version)"

# One-time: add Flutter to your PATH (re-open your shell after editing)
echo 'export PATH="$HOME/.local/share/flutter/current/bin:$PATH"' >> ~/.bashrc
```

The script verifies the SHA256 against `releases_linux.json`, so the tarball
can't be tampered with in transit. Idempotent — re-running on an already-
installed version is a no-op.

## Flutter Version

The version used by the project is in [.flutter-version](./.flutter-version).
This is also what CI reads (`.github/workflows/build.yml`,
`deploy-template.yml`), so local and CI stay in sync by editing this file.

To upgrade:
1. Bump the version in `.flutter-version` (e.g. `3.44.2`).
2. Run `install-flutter <new-version>` locally.
3. Push — CI picks up the new version on its next run.

No IDE SDK path change needed. `install-flutter` keeps a stable symlink at
`~/.local/share/flutter/current` that follows whatever version you last
installed, so VS Code / VSCodium picks it up automatically.

## Setup Git Hooks

Install the pre-commit hook to automatically check for Dart analysis issues before each commit:

```sh
bin/install-hooks
```

## Run Locally

Add the following to /etc/hosts:
```
127.0.0.1 local.waterlilies.energy
127.0.0.1 local.hazelmead.energy
```

Run:
```sh
bin/build-local
bin/run-local [hmce]
```

## Build and Deploy to Fly

### Github Setup

In github dashboard:
- create 2 environments - "hmce" and "wlce" and for each
  - create a rule under "deployment branches and tags" that limits to only tags that match "*-hmce" and "*-wlce" respectively
  - create a secret FLY_API_TOKEN for each environment with `fly tokens create deploy --name github-action-deploy-<env> --config fly/fly-<env>.toml`

### Create Fly App

```sh
fly --config fly/fly.<esco>.toml launch --org microgridfoundry --copy-config
fly --config fly/fly.<esco>.toml scale count 1
```

### Deploy

Tag and push tag to trigger a deploy. eg. 1.0.0-wlce will deploy the wlce app from the given tag.

see the github workflow file `deploy.yml` for how this works.


