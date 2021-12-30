#! /bin/sh
#

SHP_ANALYSIS_UPDATED_DIR=$1
SHP_ANALYSIS_ORIGINAL_DIR=$2

for dirfullname in $SHP_ANALYSIS_UPDATED_DIR/*; do

	DIRNAME=$(basename "${dirfullname%}")

	mkdir -p ${SHP_ANALYSIS_ORIGINAL_DIR}/${DIRNAME}
	cp -u ${dirfullname}/* ${SHP_ANALYSIS_ORIGINAL_DIR}/${DIRNAME}

done
