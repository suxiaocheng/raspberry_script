#!/bin/sh

MOUNT_DIR=~/tmp/rasp_disk

if [ ! -d ${MOUNT_DIR} ]; then
	mkdir -p ${MOUNT_DIR}
fi

sudo mount.cifs //192.168.199.210/root ${MOUNT_DIR} -o username=pi,password=Aa

