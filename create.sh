#!/bin/sh

GeneratePage () {
	TEMPLATE=$(sed -n '4p' $1)
	FPATH="$BUILD_PATH/$(dirname $1 | xargs basename)/$(basename -s .md $1).html"
	export TITLE=$(sed -n '1p' $1)
	export AUTHOR=$(sed -n '2p' $1)
	export DATE=$(sed -n '3p' $1)
	export CONTENT=$(sed -n '6,$p' $1 | $MD_CONVERTER)
	envsubst < $TEMPLATE > $FPATH
}

GenerateLinks() {
	ADD_LINK=$(sed -n '5p' $1)
	if [ "$ADD_LINK" != "link" ]; then
		return
	fi
	TITLE=$(sed -n '1p' $1)
	AUTHOR=$(sed -n '2p' $1)
	if [ "$AUTHOR" = "$UNKNOWN" ]; then
		AUTHOR=""
	else
		AUTHOR="$AUTHOR -"
	fi
	DATE=$(sed -n '3p' $1)
	if [ "$DATE" = "$UNKNOWN" ]; then
		DATE=""
	else
		DATE="$DATE -"
	fi
	echo "$DATE $AUTHOR [$TITLE]($(basename -s .md $1).html)" >> "$LINKS"
}

GenerateFolder() {
	mkdir -p "$BUILD_PATH/$(basename "$1")"
	echo "$BUILD_PATH/$(basename $1)"
	find "$ARTICLES_PATH/$1"/* | while read file; do GenerateLinks "$file"; done
	[ -f "$LINKS" ] && export FOOTER=$(cat $LINKS | sort -r | sed -e 's/$/  /' | $MD_CONVERTER) || export FOOTER=""
	export CATEGORY=$(basename $1)
	find "$ARTICLES_PATH/$1"/* | while read file; do GeneratePage "$file"; done
	[ -f "$LINKS" ] && rm "$LINKS"
}

. ./.bsmlrc
rm -r $BUILD_PATH
mkdir -p $BUILD_PATH
find "$ARTICLES_PATH" -maxdepth 1 | sed -n '2,$p' | while read file; do GenerateFolder "$(basename $file)"; done
echo "done"
