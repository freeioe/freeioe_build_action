# !/usr/bin/env sh

set -e

FILE_DIR="$1"

if [ ! -n "$2" ]
then
	RELEASE_DIR="$2"
else
	RELEASE_DIR=/__install
fi

### Get the version by count the commits
VERSION=`git log --oneline | wc -l | tr -d ' '`

### Generate the revision by last commit
set -- $(git log -1 --format="%ct %h")
R_SECS="$(($1 % 86400))"
R_YDAY="$(date --utc --date="@$1" "+%y.%j")"
REVISION="$(printf 'git-%s.%05d-%s' "$R_YDAY" "$R_SECS" "$2")"

echo 'Version:'$VERSION
echo 'Revision:'$REVISION

if [ -f "$RELEASE_DIR/$VERSION.tar.gz" ]
then
	echo 'skynet already released'
	exit
fi

cd $FILE_DIR

echo $VERSION > version
echo $REVISION >> version

################################
du . -sh

mkdir -p $RELEASE_DIR
tar czvf $RELEASE_DIR/$VERSION.tar.gz * > /dev/null
md5sum -b $RELEASE_DIR/$VERSION.tar.gz > $RELEASE_DIR/$VERSION.tar.gz.md5
du $RELEASE_DIR/$VERSION.tar.gz -sh
cat $RELEASE_DIR/$VERSION.tar.gz.md5
