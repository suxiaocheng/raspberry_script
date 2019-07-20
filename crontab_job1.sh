#!/bin/bash

set -e
RASP_CONFIG_DIR=~/program/raspberry_script
current_date=`date "+%y%m%d %H:%M:%S"`

CHECK_DIR[0]="shell_extend"
CHECK_DIR[1]="vim_plugin"
#CHECK_DIR[]=""


if [ ! -d ${RASP_CONFIG_DIR} ]; then
	RASP_CONFIG_DIR=~/program/shell/raspberry_script
	if [ ! -d ${RASP_CONFIG_DIR} ]; then
		echo "program dir ${RASP_CONFIG_DIR} not exist"
		exit 1
	fi
fi

cd ${RASP_CONFIG_DIR}
git pull
git merge origin/master

echo "************************"
echo "date: ${current_date}"
echo "************************"

for ((i=0; i< ${#CHECK_DIR[*]}; i++)); do
        echo "+++++++++begin++++++++++"
	echo ${CHECK_DIR[i]}
	BACKPWD=`pwd`
	cd ${CHECK_DIR[i]}
	./install.sh
	cd ${BACKPWD}
        echo "++++++++++end+++++++++++"
done

echo ""
echo ""


