#!/bin/sh

MD_CONVERTER="smu"
ARTICLES_PATH="articles"
BUILD_PATH="build"
TEMPLATE="template.html"
LINKS="links"

GeneratePage () {
	export TITLE=$(sed -n '1p' $1)
	export AUTHOR=$(sed -n '2p' $1)
	export DATE=$(sed -n '3p' $1)
	FNAME=$(echo $1 | xargs basename -s .md)
	FPATH="$BUILD_PATH/$FNAME.html"
	export CONTENT=$(sed -n '4,$p' $1 | $MD_CONVERTER)
	export FOOTER=$(cat $LINKS | sort -r | sed -e 's/$/  /' | $MD_CONVERTER) 
	envsubst < $TEMPLATE > $FPATH
}

GenerateLinks() {
	TITLE=$(sed -n '1p' $1)
	AUTHOR=$(sed -n '2p' $1)
	DATE=$(sed -n '3p' $1)
	FNAME=$(echo $1 | xargs basename -s .md)
	echo "$DATE - $AUTHOR - [$TITLE]($FNAME.html)" >> "$LINKS"
}

rm $LINKS
mkdir $BUILD_PATH
find "$ARTICLES_PATH"/* | while read file; do GenerateLinks "$file"; done
find "$ARTICLES_PATH"/* | while read file; do GeneratePage "$file"; done
rm $LINKS
echo "done"
