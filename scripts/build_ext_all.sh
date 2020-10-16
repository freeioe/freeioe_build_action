#!/usr/bin/env bash

set -e

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")
echo $SCRIPTPATH

BUILD_LIB=$1
CUR_DIR=`pwd`


if [ ! -n "$2" ]
WORKDIR=$CUR_DIR
else
WORKDIR=$2
fi

mkdir -p ${CUR_DIR}/__install
mkdir -p ${CUR_DIR}/__output

printf "CUR_DIR: $CUR_DIR WORK_DIR: $WORKDIR \n"

cd $WORKDIR

# Get all platforms
source $SCRIPTPATH/plats.sh

for item in "${!plats[@]}"; 
do
	if [ "$BUILD_LIB" == "opcua" ]; then
		bash $SCRIPTPATH/build_ext_opcua.sh $item ${plats[$item]} $CUR_DIR
	fi
	mkdir -p ${CUR_DIR}/__install/$item/
	bash $SCRIPTPATH/build_ext.sh $item ${plats[$item]} ${CUR_DIR}/__install/$item/
done

cd $CUR_DIR

bash $SCRIPTPATH/gen_output.sh ${CUR_DIR}/__install ${CUR_DIR}/__output

ls ${CUR_DIR}/__output/*
