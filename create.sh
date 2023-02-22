#!/bin/sh

MD_CONVERTER="smu"
ARTICLES_PATH="articles"
BUILD_PATH="build"
TEMPLATE="template.html"

GeneratePage () {
	export TITLE=$(sed -n '1p' $1)
	export AUTHOR=$(sed -n '2p' $1)
	export DATE=$(sed -n '3p' $1)
	FNAME=$(echo $1 | xargs basename -s .md)
	FPATH="$BUILD_PATH/$FNAME.html"
	echo "$FPATH"
	export CONTENT=$(sed -n '4,$p' $1 | $MD_CONVERTER)
	envsubst < $TEMPLATE > $FPATH
	echo "done"
}

find $ARTICLES_PATH/* | while read file; do GeneratePage "$file"; done
