#!/bin/sh

BIN_DIR=`dirname $0`
PROJECT_ROOT=`dirname $BIN_DIR`

PUBSPEC_FILE=$PROJECT_ROOT/app/pubspec.yaml

getGitCommit() {
  echo `git rev-parse --short HEAD`
}

getAppVersion() {
  grep "^version:" $PUBSPEC_FILE | sed -e 's/version: *//' -e 's/+.*//'
}

getBuildNumber() {
  grep "^version:" $PUBSPEC_FILE | sed -e 's/.*+//'
}

incrementBuildNumber() {
  VERSION=`getAppVersion`
  BUILD_NUMBER=`getBuildNumber`
  NEW_BUILD_NUMBER=`expr $BUILD_NUMBER + 1`
  sed -i -e "s/^version:.*/version: $VERSION+$NEW_BUILD_NUMBER/" $PUBSPEC_FILE
  echo $NEW_BUILD_NUMBER
}

getFlutterVersion() {
  echo `flutter --version | grep "^Flutter" | sed -e 's/^Flutter \([^ ]*\).*/\1/'`
}