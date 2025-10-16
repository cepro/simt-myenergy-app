# Simtricity MyEnergy App

This repo holds the code for the MyEnergy app and the scripts to build it.

See the repositories [simt-myenergy-gh-pages-qa](https://github.com/cepro/simt-myenergy-gh-pages-qa) and [simt-myenergy-gh-pages-prod](https://github.com/cepro/simt-myenergy-gh-pages-prod). Build code is pushed to there and deployed to github pages which is where the app gets hosted.

## Install Tools

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

## Build for fly

Run the following to build the app ready for a `fly deploy`.
```sh
bin/build-fly <hmce|wlce>
```

The script will:
 - apply patches
 - build it
 - copy files to local build/web where fly and docker will pick it up

### Create

```sh
fly --config fly/fly.<esco>.toml launch --org microgridfoundry --copy-config
fly --config fly/fly.<esco>.toml scale count 1
```

### Deploy / Update

```sh
fly --config fly/fly.<esco>.toml deploy
```

