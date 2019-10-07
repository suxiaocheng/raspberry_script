#!/bin/bash

MOUNT_DIR=~/server_raspberry

if [ ! -d $MOUNT_DIR ]; then
	mkdir ${MOUNT_DIR}
fi

MOUNT_STATUS=`mount |grep ${MOUNT_DIR}`
if [ "$?" == "0" ]; then
	echo "[INFO] ${MOUNT_DIR} is already mount, exit..."
	exit 0
fi


sudo mount -t cifs //10.0.0.1/root ${MOUNT_DIR} -o user="pi",pass="Aa",uid=$(id -u),gid=$(id -u)

if [ "$?" == "0" ]; then
	echo "[INFO] mount sucessfully"
else
	echo "[ERROR] mount sucessfully"
fi
