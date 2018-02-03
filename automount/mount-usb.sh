#!/bin/sh
if [ ! -d /media/$1 ]; then
	mkdir -p /media/$1
	chown pi:pi /media/$1
fi
/bin/mount -t vfat /dev/$1 /media/$1
sync
