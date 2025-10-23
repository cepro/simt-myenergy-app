#!/bin/sh

BIN_DIR=`dirname $0`
PROJECT_ROOT=`dirname $BIN_DIR`

VERSION_FILE=$PROJECT_ROOT/myenergy.version

getGitCommit() {
  echo `git rev-parse --short HEAD`
}

getAppVersion() {
  grep version= $VERSION_FILE | sed -e 's/version=//'
}

getBuildNumber() {
  grep build= $VERSION_FILE | sed -e 's/build=//'
}

incrementBuildNumber() {
  BUILD_NUMBER=`getBuildNumber`
  NEW_BUILD_NUMBER=`expr $BUILD_NUMBER + 1`
  sed -i -e "s/build=.*/build=$NEW_BUILD_NUMBER/" $VERSION_FILE
  echo $NEW_BUILD_NUMBER
}

getFlutterVersion() {
  echo `flutter --version | grep "^Flutter" | sed -e 's/^Flutter \([^ ]*\).*/\1/'`
}