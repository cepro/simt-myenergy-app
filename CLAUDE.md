# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the Simtricity MyEnergy Flutter app - a web-based energy management application built with Flutter and FlutterFlow. The app is deployed to GitHub Pages and uses Supabase as the backend.

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
# Build for deployment to GitHub Pages
bin/build-github-pages <qa|prod|mgf>
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
- `flutterflow-export/` - Original FlutterFlow exported code (read-only)
- `local-stage/` - Working copy for local development with patches applied
- `patches/` - Patches applied to customize FlutterFlow export
  - `patches/local/` - Local development patches (Supabase URL override)
  - `patches/prod/` - Production patches
  - `patches/sentry/` - Sentry error tracking patches
- `bin/` - Build and utility scripts

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

1. Export from FlutterFlow using `bin/flutterflow-export`
2. Build local version using `bin/build-local`
3. Run locally using `bin/run-local`
4. Test changes
5. Build for deployment using `bin/build-github-pages`

## Patch System
The build process applies patches to customize the FlutterFlow export:
- Environment-specific configuration (URLs, keys)
- Sentry integration
- Theme customizations
- GitHub Pages compatibility fixes

Always work from `local-stage/` directory for development. Never modify `flutterflow-export/` directly as it gets overwritten.

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