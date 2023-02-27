#!/bin/sh

MD_CONVERTER="smu"
ARTICLES_PATH="articles"
BUILD_PATH="build"
TEMPLATE="template.html"
LINKS="links"

GeneratePage () {
	TEMPLATE=$(sed -n '4p' $1)
	FPATH="$BUILD_PATH/$(dirname $1 | xargs basename)/$(basename -s .md $1).html"
	export TITLE=$(sed -n '1p' $1)
	export AUTHOR=$(sed -n '2p' $1)
	export DATE=$(sed -n '3p' $1)
	export CONTENT=$(sed -n '5,$p' $1 | $MD_CONVERTER)
	envsubst < $TEMPLATE > $FPATH
}

GenerateLinks() {
	TITLE=$(sed -n '1p' $1)
	AUTHOR=$(sed -n '2p' $1)
	DATE=$(sed -n '3p' $1)
	echo "$DATE - $AUTHOR - [$TITLE]($(basename -s .md $1).html)" >> "$LINKS"
}

GenerateFolder() {
	mkdir -p "$BUILD_PATH/$(basename "$1")"
	echo "$BUILD_PATH/$(basename $1)"
	find "$ARTICLES_PATH/$1"/* | while read file; do GenerateLinks "$file"; done
	export FOOTER=$(cat $LINKS | sort -r | sed -e 's/$/  /' | $MD_CONVERTER) 
	export CATEGORY=$(basename $1)
	find "$ARTICLES_PATH/$1"/* | while read file; do GeneratePage "$file"; done
	rm $LINKS
}

rm -r $BUILD_PATH
mkdir -p $BUILD_PATH
find "$ARTICLES_PATH" -maxdepth 1 | sed -n '2,$p' | while read file; do GenerateFolder "$(basename $file)"; done
echo "done"
