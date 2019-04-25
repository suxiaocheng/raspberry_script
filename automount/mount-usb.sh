#!/bin/sh

LOG_FILE=/var/log/tmp.txt

echo "**Going to mount $1" >> $LOG_FILE

id -a >> $LOG_FILE

if [ ! -d /media/$1 ]; then
	mkdir -p /media/$1
	chown pi:pi /media/$1
fi
/bin/mount -t vfat -o gid=1000,uid=1000 /dev/$1 /media/$1 2>>$LOG_FILE  >> $LOG_FILE

if [ "$?" -eq "0" ]; then
	# printout the mount information
	count=0
	while [ ${count} -le 20 ]
	do
		dat=`mount |grep "$1"`
		if [ -n ${dat} ]; then
			echo "info: ${dat}" >> $LOG_FILE
			break
		else
			echo "info: still trying ${count}" >> $LOG_FILE
		fi
		count=$(($count+1))
		sleep 1
	done
	echo "mount $1 sucessfully" >> $LOG_FILE
else
	echo "mount $1 fail" >> $LOG_FILE
fi

