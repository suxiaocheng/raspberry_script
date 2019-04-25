#!/bin/sh

LOG_FILE=/var/log/tmp.txt

echo "**Going to umount $1" >> $LOG_FILE

# check if directory is mount
dat=`mount |grep "$1"`


if [ -z "$dat"]; then
        echo "Not mount: " $1 >> $LOG_FILE
	if [ -d /media/$1 ]; then
		rm -rf /media/$1
		echo "remove exist dir /media/$1" >> $LOG_FILE
	fi
else
	echo "info: $dat" >> $LOG_FILE
        /bin/umount /dev/$1 2>>$LOG_FILE >>$LOG_FILE
        if [ "$?" = "0" ]; then
                rm -rf /media/$1
	else
		echo "umount /dev/$1 fail" >> $LOG_FILE
        fi  
fi
