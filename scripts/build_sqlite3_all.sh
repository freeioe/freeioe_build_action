#!/usr/bin/env bash

if [ $# -lt 1 ] ; then
	echo "Usage: build_ext_all.sh <target dir>"
	exit 0
fi

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")
echo $SCRIPTPATH

TARGET_PATH=/__install
CUR_DIR=`pwd`

# Get all platforms
source $SCRIPTPATH/plats.sh

for item in "${!plats[@]}"; 
do
	mkdir -p ${TARGET_PATH}/${item}/sqlite3
	mkdir -p ${TARGET_PATH}/${item}/sqlite3/luaclib/sqlite3
	mkdir -p ${TARGET_PATH}/${item}/sqlite3/lualib

	rm build -rf
	rm bin -rf

	premake5 gmake
	if [ "${plats[$item]}" == "native" ]; then
		unset CC
		unset CXX
		unset AR
		unset STRIP
	else
		source /toolchains/${plats[$item]}
	fi

	cd build
	make config=release
	cd ..
	cp -f bin/Release/sqlite3/core.so $TARGET_PATH/${item}/sqlite3/luaclib/sqlite3
	cp -f lua-sqlite3/sqlite3.lua $TARGET_PATH/${item}/sqlite3/lualib
done
