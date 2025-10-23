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


