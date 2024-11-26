#!/bin/sh

BIN_DIR=`dirname $0`
PROJECT_ROOT=`dirname $BIN_DIR`

SYS_INFO_PAGE_SOURCE_PATH=lib/pages/sys_info_page/sys_info_page_widget.dart
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

setSysInfoEnvironment() {
  ENV=$1
  sed -i -e "s/replace_me_environment/$ENV/" $SYS_INFO_PAGE_SOURCE_PATH
}

setSysInfoSupabaseProject() {
  PROJECT=$1
  sed -i -e "s/replace_me_supabase_project/$PROJECT/" $SYS_INFO_PAGE_SOURCE_PATH
}

setSysInfoGitCommit() {
  GIT_COMMIT=$1
  sed -i -e "s/replace_me_app_git_commit/$GIT_COMMIT/" $SYS_INFO_PAGE_SOURCE_PATH
}

setSysInfoBillingBaseURI() {
  URI=$1
  sed -i -e "s/replace_me_billing_stripe_domain/$URI/" $SYS_INFO_PAGE_SOURCE_PATH
}

setSysInfoAccountsBaseURI() {
  URI=$1
  sed -i -e "s/replace_me_accounts_domain/$URI/" $SYS_INFO_PAGE_SOURCE_PATH
}

setSysInfoFlutterVersion() {
  sed -i -e "s/replace_me_flutter_version/`getFlutterVersion`/" $SYS_INFO_PAGE_SOURCE_PATH
}
