#!/usr/bin/env bash

set -e

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")
echo $SCRIPTPATH

BUILD_LIB=$1
CUR_DIR=`pwd`

printf "CUR_DIR: $CUR_DIR \n"

# Get all platforms
source $SCRIPTPATH/plats.sh

for item in "${!plats[@]}"; 
do
	if [ "$BUILD_LIB" == "opcua" ]; then
		bash $SCRIPTPATH/build_ext_opcua.sh $item ${plats[$item]} $CUR_DIR/../..
	fi
	mkdir -p /__install/$item/
	bash $SCRIPTPATH/build_ext.sh $item ${plats[$item]} /__install/$item/
done
