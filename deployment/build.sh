#!/bin/sh
EXPORT_HOME=/tmp/myenergy-flutterflow-export-`date +'%s'`
APP_HOME=$EXPORT_HOME/my_energy
THIS_PROJECT=`pwd`/`dirname $0`
GH_PAGES_HOME=$THIS_PROJECT/../../simt-myenergy-gh-pages

echo "\nExporting flutterflow code to $APP_HOME ..."
mkdir $EXPORT_HOME
flutterflow export-code --project myenergy-billing-prototype-wbk8s3 --include-assets --dest $EXPORT_HOME 2>/dev/null
cd $APP_HOME

echo "\nBuilding flutter app ..."
flutter build web

echo "\nCopying build/web to $GH_PAGES_HOME ..."
rm -rf $GH_PAGES_HOME/*
cp -r build/web/* $GH_PAGES_HOME
cd $GH_PAGES_HOME

echo "\nAdd our favicon.ico"
cp $THIS_PROJECT/favicon.ico $GH_PAGES_HOME

git restore README.md manifest.json CNAME
git status
