#!/usr/bin/env bash

set -e

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")
# echo $SCRIPTPATH

CUR_DIR=`pwd`

mkdir -p ${CUR_DIR}/__install
mkdir -p ${CUR_DIR}/__output
TARGET_PATH=${CUR_DIR}/__install

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
	make config=release verbose=1
	cd ..
	cp -f bin/Release/sqlite3/core.so $TARGET_PATH/${item}/sqlite3/luaclib/sqlite3
	cp -f lua-sqlite3/sqlite3.lua $TARGET_PATH/${item}/sqlite3/lualib
done

bash $SCRIPTPATH/gen_output.sh ${TARGET_PATH} ${CUR_DIR}/__output

ls ${CUR_DIR}/__output/*
