# AGENTS.md

This file provides guidance to AI agents when working with code in this repository.

## Project Overview

This is the Simtricity MyEnergy Flutter app - a web-based energy management application built with Flutter and FlutterFlow. The app is deployed to Fly.io and uses Supabase as the backend.

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
- `bin/` - Build and utility scripts (build-fly, run-local, sentry-release, upload-sourcemaps-to-sentry, embed-sources.py, library.sh, install-hooks, pre-commit)
- `.github/workflows/` - CI/CD workflows (build.yml, deploy.yml, deploy-template.yml)
- `nginx.conf` - nginx configuration for Fly.io deployment
- `Dockerfile` - Docker configuration for Fly.io deployment
- `fly/fly.wlce.toml` - Fly.io Waterlilies Community Energy environment configuration
- `fly/fly.hmce.toml` - Fly.io Hazelmead Community Energy environment configuration

### Flutter Version
The project uses the Flutter version specified in [`.flutter-version`](.flutter-version). The project is no longer coupled to FlutterFlow — the code is maintained directly.

### Key Dependencies
- Supabase for backend (authentication, database, storage)
- Sentry for error tracking
- Various Flutter UI packages (data_table_2, dropdown_button2, etc.)
- Custom widgets in `lib/components/`

### FlutterFlow Integration
The app is built using FlutterFlow with custom code additions:
- Custom actions in `lib/custom_code/actions/`
- Custom widgets in `lib/custom_code/widgets/`
- FlutterFlow generated code in `lib/flutter_flow/`

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

## Requirements
- Flutter version as specified in [`.flutter-version`](.flutter-version)
- Local Supabase instance for development
- Fly CLI (`flyctl`) for deployment
