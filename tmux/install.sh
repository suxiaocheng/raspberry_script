#!/bin/sh

binary_name=".tmux.conf"
binary_dir="$HOME"

if [ ! -d "${binary_dir}" ]; then
	echo "${binary_dir} directory is not exist"
	mkdir "${binary_dir}"
fi

if [ ! -f ${binary_dir}"/"${binary_name} ]; then
	echo "${binary_name} is not exist"
fi

cp ${binary_name} ${binary_dir}"/"${binary_name}
chmod 0777 ${binary_dir}"/"${binary_name}

echo "sucessfully"
