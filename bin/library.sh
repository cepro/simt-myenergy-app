#!/bin/sh

BIN_DIR=`dirname $0`
PROJECT_ROOT=`dirname $BIN_DIR`

getGitCommit() {
  echo `git rev-parse --short HEAD`
}

getFlutterVersion() {
  echo `flutter --version | grep "^Flutter" | sed -e 's/^Flutter \([^ ]*\).*/\1/'`
}

SYS_INFO_PAGE_SOURCE_PATH=lib/sys_info_page/sys_info_page_widget.dart

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
