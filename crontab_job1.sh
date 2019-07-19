#!/bin/bash

set -e
RASP_CONFIG_DIR=~/program/raspberry_script
current_date=`date "+%y%m%d %H:%M:%S"`

CHECK_DIR[0]="shell_extend"
CHECK_DIR[1]="vim_plugin"
#CHECK_DIR[]=""


if [ ! -d ${RASP_CONFIG_DIR} ]; then
	exit 1
fi

cd ${RASP_CONFIG_DIR}
git pull
git merge origin/master

for ((i=0; i< ${#CHECK_DIR[*]}; i++)); do
        echo "+++++++++begin++++++++++"
	echo "date: ${current_date}"
	echo ${CHECK_DIR[i]}
        echo "========================"
	BACKPWD=`pwd`
	cd ${CHECK_DIR[i]}
	./install.sh
	cd ${BACKPWD}
        echo "++++++++++end+++++++++++"
done


