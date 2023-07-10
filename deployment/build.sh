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

HTML=build/web/index.html
echo "\nAdding SPA github pages snippet to $HTML ..."
 
SPLIT_LINE_NUM=`grep -n "</head>" $HTML | cut -d: -f1`
NUM_LINES=`wc -l $HTML | cut -d" " -f1`

NEW_HTML=$HTML.new
head -`expr $SPLIT_LINE_NUM - 1` $HTML > $NEW_HTML
cat $THIS_PROJECT/gh-pages-hack-snippet.html >> $NEW_HTML
tail -`expr $NUM_LINES - $SPLIT_LINE_NUM + 1` $HTML >> $NEW_HTML
mv $NEW_HTML $HTML

echo "\nCopying build/web to $GH_PAGES_HOME ..."
rm -rf $GH_PAGES_HOME/*
cp -r build/web/* $GH_PAGES_HOME
cd $GH_PAGES_HOME

echo "\nAdd our favicon.ico"
cp $THIS_PROJECT/favicon.ico $GH_PAGES_HOME

# we blow away everything before copying over the flutter app
# but we want the following files as customizations and addons:
git restore README.md manifest.json CNAME 404.html

git status
