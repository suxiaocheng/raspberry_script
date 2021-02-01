#!/bin/bash

TARGET_DIR=~/bin/

if [ ! -d ${TARGET_DIR} ]; then
	mkdir ${TARGET_DIR}
	if [ $? -ne 0 ]; then
		echo "[ERROR] mkdir ${TARGET_DIR} fail"
		exit 1;
	fi
fi

cp android/enable_ccached.sh ${TARGET_DIR}
