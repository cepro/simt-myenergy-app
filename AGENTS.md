# AGENTS.md

This file provides guidance to AI agents when working with code in this repository.

## Project Overview

This is the Simtricity MyEnergy Flutter app - a web-based energy management application built with Flutter. The app is deployed to Fly.io and uses Supabase as the backend.

## Codebase Maintenance (IMPORTANT)

**The project is no longer coupled to FlutterFlow and is not regenerated from
it.** The codebase originated as a FlutterFlow export, but it is now
maintained directly by hand: edit files under `app/lib/` (including the
`flutter_flow/` and `custom_code/` directories) as normal Flutter source.
There is no code generation step and no FlutterFlow sync — feel free to edit
generated-looking files (`*_widget.dart`, `*_model.dart`, action blocks, etc.)
directly. Treat the whole `app/` tree as ordinary, hand-maintained Flutter
code.

## Build System and Scripts

The project uses a custom build system with shell scripts in the `bin/` directory:

### Local Development
```bash
bin/run-local [hmce]  # runs on local.waterlilies.energy:4242 or local.hazelmead.energy:4242
```

### Sentry Source Maps
```bash
bin/upload-sourcemaps-to-sentry   # Upload source maps after a build
bin/sentry-release                # Create a Sentry release
```

### Flutter Commands
Standard Flutter commands work from the `app/` directory:
```bash
cd app/
flutter build web --source-maps --pwa-strategy none
flutter test
flutter analyze
```

## Architecture

### Directory Structure
- `app/` - Flutter app code
- `assets/` - Environment-specific assets (hmce/, wlce/ subdirs)
- `build/web/` - Flutter web build output (created by build scripts, used for Fly.io deployment)
- `bin/` - Build and utility scripts (build-fly, bump-version, tag-release, run-local, sentry-release, upload-sourcemaps-to-sentry, embed-sources.py, library.sh, install-hooks, pre-commit)
- `.github/workflows/` - CI/CD workflows (build.yml, deploy.yml, deploy-template.yml)
- `nginx.conf` - nginx configuration for Fly.io deployment
- `Dockerfile` - Docker configuration for Fly.io deployment
- `fly/fly.wlce.toml` - Fly.io Waterlilies Community Energy environment configuration
- `fly/fly.hmce.toml` - Fly.io Hazelmead Community Energy environment configuration

### Flutter Version
The project uses the Flutter version specified in [`.flutter-version`](.flutter-version). The project is no longer coupled to FlutterFlow — the code is maintained directly (see "Codebase Maintenance" above).

### Key Dependencies
- Supabase for backend (authentication, database, storage)
- Sentry for error tracking
- Various Flutter UI packages (data_table_2, dropdown_button2, etc.)
- Custom widgets in `lib/components/`

### FlutterFlow Origin (legacy)
The codebase originated as a FlutterFlow export and is now maintained directly by hand (no generation, no sync — see "Codebase Maintenance" above). The historical FlutterFlow layout is preserved:
- Custom actions in `lib/custom_code/actions/`
- Custom widgets in `lib/custom_code/widgets/`
- Supporting framework/runtime helpers in `lib/flutter_flow/`

### Authentication & Backend
- Supabase authentication with email/password
- JWT token handling for API calls
- Real-time subscriptions for live data updates
- Local development uses localhost:8000 Supabase instance

## Development Workflow

### Local Development
1. Run locally using `bin/run-local`
2. Test changes

### Deployment to Fly.io
Push a git tag ending in `-wlce` or `-hmce` to trigger the GitHub Actions deploy workflow.

## Deployment

### CI/CD via GitHub Actions (preferred)
Deployment is handled entirely by GitHub Actions — do not run `fly deploy` manually.

Push a git tag matching `**-wlce` or `**-hmce` to trigger the deploy workflow (`.github/workflows/deploy.yml`), which calls the shared template (`.github/workflows/deploy-template.yml`) to:
1. Build the Flutter app via `bin/build-fly <env>`
2. Build a Docker image
3. Deploy to Fly.io via `flyctl deploy`
4. Commit the incremented build number back to `main`

- Tags ending in `-wlce` deploy to Waterlilies Community Energy
- Tags ending in `-hmce` deploy to Hazelmead Community Energy

A separate `build.yml` workflow runs `bin/build-fly hmce` on every push as a CI check.

The `bin/build-fly` script:
- Creates a temporary build directory
- Applies environment-specific patches
- Increments build number
- Runs `flutter build web` with source maps
- Injects build number into script hrefs for cache busting
- Copies build artifacts to `build/web/` for Docker deployment

### Versioning and Tagging

Two scripts manage the version lifecycle before pushing the deploy tag:

```bash
bin/bump-version <X.Y.Z>                              # Edit app/pubspec.yaml to <X.Y.Z>+<current_build>
bin/tag-release <X.Y.Z> [-wlce|-hmce|-both]           # Tag and push to trigger deploy
```

`pubspec.yaml` holds `version: X.Y.Z+NNNN`. The `+NNNN` build number is **auto-incremented** by `bin/build-fly` on every deploy and committed back to `main` by the deploy workflow — never hand-edit it. The semantic `X.Y.Z` is what you control.

To cut a release:

```bash
bin/bump-version 3.6.0             # edits app/pubspec.yaml -> 3.6.0+<current_build>
git add app/pubspec.yaml
git commit -m "bump to 3.6.0"
bin/tag-release 3.6.0 -both        # creates and pushes 3.6.0-wlce and 3.6.0-hmce
```

`tag-release` checks that pubspec is at the requested version, that you are on `main`, and that the version bump is committed, before pushing each tag. It refuses to push tags that already exist locally. Run either script with `-h` or `--help` for full usage.

### Fly.io Deployment
The app is deployed as a static site using nginx in a Docker container:
- **Dockerfile**: Uses nginx:alpine base image, copies build output and custom nginx config
- **nginx.conf**: Configures SPA routing with `try_files`, cache headers, and gzip compression
- **fly/fly.wlce.toml**: Waterlilies Community Energy environment config
- **fly/fly.hmce.toml**: Hazelmead Community Energy environment config

Cache busting is handled by injecting the build number into script hrefs in index.html (e.g., `script.js?v=123`).

## Testing
```bash
cd app/
flutter test
```

`flutter test` also runs in the pre-commit hook (`bin/pre-commit`) whenever
`.dart` files are staged.

### Native-runner constraint (important)

`flutter test` runs on the native (VM) runner, but the app's `lib/main.dart`
import chain pulls in `package:web` (via Supabase), and the pinned `web`
package does **not** compile under the native runner with the current Dart
SDK. `flutter test` compiles *all* test files together and aborts if any one
fails to load, so a single offending test would block every commit.

The chain is: every struct → `backend/schema/util/schema_util.dart` →
`flutter_flow/flutter_flow_util.dart` → `../main.dart` → Supabase →
`package:web`. So importing app/widget types (structs, widgets, anything that
reaches `flutter_flow_util.dart`) from a test breaks the suite.

**Therefore: write unit tests against pure logic that imports no app types.**
Extract testable decisions into small, import-free helper functions that take
plain data (e.g. records, primitives) and keep the widget/struct adaptation in
the call site — see `test/custom_code/models/quickchart_service_test.dart` for
the pattern.

Widget tests are fine as long as the widget only uses plain Material and
import-free types (pass theme text styles in as parameters rather than calling
`FlutterFlowTheme.of`, which imports app state). Widget tests that need the
app graph would have to run on the web runner (`flutter test --platform
chrome`), which is not part of the default suite.
A proper fix would be to break the `import '../main.dart'` coupling in
`flutter_flow_util.dart` (it uses `MyApp.of(context)` for theme/route state);
that is a larger refactor tracked separately.

## Requirements
- Flutter version as specified in [`.flutter-version`](.flutter-version)
- Local Supabase instance for development
- Fly CLI (`flyctl`) for deployment
