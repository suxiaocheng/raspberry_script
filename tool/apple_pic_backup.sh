#!/bin/bash

PHONE_ADDR="/run/user/1000/gvfs/gphoto2:host=%5Busb%3A001%2C003%5D/DCIM"
BACKUP_DIR="/home/suxiaocheng/icloud"

if [ ! -d ${PHONE_ADDR} ];then
	echo "[ERROR] ${PHONE_ADDR} is not exist"
	exit 1	
fi

pushd ${PHONE_ADDR}
PIC_LIST=`find . -type f`
copy_count=0
err_copy_count=0
skip_count=0

for file in ${PIC_LIST}
do
	filename=`echo $file | awk -F '/' '{print $3}'`
	# echo "[INFO] file [${file}], filename [${filename}]"

	if [ ! -f ${BACKUP_DIR}"/"${filename} ]; then
		echo "[INFO] ${filename} is not exist"
		cp $file $BACKUP_DIR
		if [ $? -eq 0 ]; then
			copy_count=$(($copy_count+1))
		else
			echo "[ERROR] copy $filename met error"
			err_copy_count=$(($err_copy_count+1))
		fi
	else
		echo "[INFO] ${filename} is found"
		skip_count=$(($skip_count+1))
	fi
done

echo "[INFO] Done with $copy_count file copy"
echo "[INFO] $skip_count file skip"
echo "[INFO] $err_copy_count file err"

popd 
