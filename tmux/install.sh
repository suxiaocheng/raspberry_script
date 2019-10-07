#!/bin/bash

source ../basic/helper.sh

binary_name=".tmux.conf"
binary_dir="$HOME"

TMUX_PROGRAM=`which tmux`

if [ -z $TMUX_PROGRAM ]; then
	sudo apt install -y tmux
	if [[ "$?" -ne 0 ]]; then
		echo "tmux install fail"
		exit 1
	else
		echo "tmux is not exist, install ok"
	fi
fi

if [ ! -d "${binary_dir}" ]; then
	echo "${binary_dir} directory is not exist"
	mkdir "${binary_dir}"
fi

if [ ! -f ${binary_dir}"/"${binary_name} ]; then
	echo "${binary_name} is not exist"
fi

tmux_version=`tmux -V|tmux -V|awk '{print $2}'`

version_cmp $tmux_version 2.3
if [[ ! "$?" -eq 2 ]]; then
	source_binary_name=$binary_name
else
	source_binary_name=$binary_name"_2.6"
fi

cp ${source_binary_name} ${binary_dir}"/"${binary_name}
chmod 0777 ${binary_dir}"/"${binary_name}

echo "sucessfully"
