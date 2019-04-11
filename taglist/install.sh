#!/bin/sh

binary_dir="$HOME""/.vim"

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

rm -rf ${binary_dir}/doc ${binary_dir}/plugin

cp -r doc plugin ~/.vim/

if [ "$?" -eq "0" ]; then
	echo "sucessfully"
else
	echo "fail to copy file"
fi

