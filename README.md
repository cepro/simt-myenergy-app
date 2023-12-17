# Simtricity MyEnergy App

This repo holds the code for the MyEnergy app.

## Get Started

Install:
- [Flutterflow cli](https://github.com/FlutterFlow/flutterflow-cli)
- [fvm](https://fvm.app/docs/getting_started/installation)

## Flutter Version

The version used by the project is in [.flutter-version](./.flutter-version).

We use the same flutter version that Flutterflow uses which can be seen in the top left corner of the FlutterFlow UI:

![FlutterFlow UI Version](./ff-ui-version.png)

Manually update .flutter-version when Flutterflow upgrades this Flutter version.

## Folders

flutterflow-export/
- export app code from flutterflow
- track copies of the original flutterflow code without any modifications

local-stage/
- local build (see [bin/build-local](bin/build-local))
- local dev runs from this copy (see [bin/run-local](bin/run-local))

patches/
- patches to be applied to the flutterflow export code

## Run Locally

```sh
bin/flutterflow-export
bin/build-local
bin/run-local
```

## Build for github pages deployment

```sh
bin/build-github-pages
```
