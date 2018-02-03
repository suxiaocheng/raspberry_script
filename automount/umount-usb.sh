#!/bin/sh

# check if directory is mount
dat=`mount |grep "$1"`

if [ "$?" -eq 1 ]; then
        echo "Not mount: " $1
else
        /bin/umount /dev/$1
        if [ "$?" = "0" ]; then
                rm -rf /media/$1
        fi  
        sync
fi
