# !/usr/bin/env sh

set -e

FILE_DIR="$1"
RELEASE_DIR="$2"

printf "SRC: $FILE_DIR \t TARGET: $RELEASE_DIR \n"

mkdir -p ${RELEASE_DIR}

cd $FILE_DIR

################################
du . -sh

mkdir -p $RELEASE_DIR
tar czvf $RELEASE_DIR/files.tar.gz * > /dev/null
md5sum -b $RELEASE_DIR/files.tar.gz > $RELEASE_DIR/files.tar.gz.md5
du $RELEASE_DIR/files.tar.gz -sh
cat $RELEASE_DIR/files.tar.gz.md5
