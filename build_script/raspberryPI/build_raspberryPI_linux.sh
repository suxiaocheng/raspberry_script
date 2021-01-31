#!/bin/bash

TARGET_DIR=~/program/linux/

start_date=$(date)

check_exit_code() {
        if [ "$?" -ne "0" ]; then
                echo "program exit unnormal $1"
                exit 1
        fi
}

cpus=`cat /proc/cpuinfo|grep processor | wc -l 2>&1`
if [ $cpus -gt 0 ];then
	if [ $cpus -gt 2 ]; then
		cpus=$((cpus-1))
	fi
else
	cpus=2
fi
echo "Number of build thread is $cpus"

if [ -d ${TARGET_DIR} ]; then
	pushd ${TARGET_DIR}

	make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig 2>&1 | tee build.log
	check_exit_code "make defconfig fail"
	make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- zImage modules dtbs -j${cpus} 2>&1 | tee build.log
	check_exit_code "make target fail"

	popd

	echo "==========================="
	echo "start build at: ${start_date}"
	echo "finish build at: $(date)"
	echo "==========================="
else
	echo "[ERROR] Target {$TARGET_DIR} is missing!!!"
fi
