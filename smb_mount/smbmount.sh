#!/bin/sh

MOUNT_DIR=~/tmp/rasp_disk

if [ ! -d ${MOUNT_DIR} ]; then
	mkdir -p ${MOUNT_DIR}
fi

sudo mount.cifs //10.0.0.1/root ${MOUNT_DIR} -o username=pi,password=Aa

