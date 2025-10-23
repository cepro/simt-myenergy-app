# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the Simtricity MyEnergy Flutter app - a web-based energy management application built with Flutter and FlutterFlow. The app is deployed to Fly.io and uses Supabase as the backend.

## Build System and Scripts

The project uses a custom build system with shell scripts in the `bin/` directory:

### Local Development
```bash
# Export from FlutterFlow and build locally
bin/build-local [--export]

# Run locally (requires /etc/hosts entries)
bin/run-local [hmce]  # runs on local.waterlilies.energy:4242 or local.hazelmead.energy:4242
```

### Production Builds
```bash
# Build for deployment to Fly.io
bin/build-fly <wlce|hmce>

# Deploy to Fly.io (after building)
fly deploy --config fly/fly.wlce.toml    # Waterlilies Community Energy
fly deploy --config fly/fly.hmce.toml    # Hazelmead Community Energy

# Legacy GitHub Pages build (deprecated)
bin/build-github-pages <qa|prod>
```

### Flutter Commands
Standard Flutter commands work from the `local-stage/` directory:
```bash
cd local-stage/
flutter build web --source-maps --pwa-strategy none
flutter test
flutter analyze
```

## Architecture

### Directory Structure
- `app/` - Flutter app code
- `build/web/` - Flutter web build output (created by build scripts, used for Fly.io deployment)
- `bin/` - Build and utility scripts
- `nginx.conf` - nginx configuration for Fly.io deployment
- `Dockerfile` - Docker configuration for Fly.io deployment
- `fly/fly.wlce.toml` - Fly.io Waterlilies Community Energy environment configuration
- `fly/fly.hmce.toml` - Fly.io Hazelmead Community Energy environment configuration

### Flutter Version
The project uses Flutter 3.32.4 (defined in `.flutter-version`). This must match the FlutterFlow version shown in their UI.

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
1. Build local version using `bin/build-local`
2. Run locally using `bin/run-local`
3. Test changes

### Deployment to Fly.io
1. Build for target environment: `bin/build-fly <wlce|hmce>`
2. Deploy: `fly deploy --config fly/fly.<wlce|hmce>.toml`

The build script:
- Creates a temporary build directory
- Applies environment-specific patches
- Increments build number
- Runs `flutter build web` with source maps
- Injects build number into script hrefs for cache busting
- Copies build artifacts to `build/web/` for Docker deployment

## Deployment

### Fly.io Deployment
The app is deployed as a static site using nginx in a Docker container:
- **Dockerfile**: Uses nginx:alpine base image, copies build output and custom nginx config
- **nginx.conf**: Configures SPA routing with `try_files`, cache headers, and gzip compression
- **fly/fly.wlce.toml**: Waterlilies Community Energy environment config
- **fly/fly.hmce.toml**: Hazelmead Community Energy environment config

Cache busting is handled by injecting the build number into script hrefs in index.html (e.g., `script.js?v=123`).

## Testing
Run tests from the `local-stage/` directory:
```bash
cd local-stage/
flutter test
```

## Requirements
- Flutter 3.32.4 (use fvm: `fvm use 3.32.4`)
- FlutterFlow CLI
- Local Supabase instance for development
- Fly CLI (`flyctl`) for deployment