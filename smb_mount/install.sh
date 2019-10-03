#!/bin/sh

binary_dir="$HOME""/bin"

SCRIPT_NAME="mount_server_raspberry.sh"

if [ ! -d "${binary_dir}" ]; then
	echo "${binary_dir} directory is not exist"
	mkdir "${binary_dir}"
	
	if [ "$?" -eq "0" ]; then
		echo "sucessfully create dir"
	else
		echo "fail to create ${binary_dir}, exit"
		exit 1
	fi
fi

cp $SCRIPT_NAME $binary_dir

if [ "$?" -eq "0" ]; then
	echo "sucessfully"
else
	echo "fail to copy file"
fi

