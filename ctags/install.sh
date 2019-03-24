#!/bin/sh

binary_name="update_ctags.sh"
binary_dir="$HOME""/bin"

if [ ! -d "${binary_dir}" ]; then
	echo "${binary_dir} directory is not exist"
	mkdir "${binary_dir}"
fi

if [ ! -f ${binary_dir}"/"${binary_name} ]; then
	echo "${binary_name} is not exist"
fi

cp ${binary_name} ${binary_dir}"/"${binary_name}
chmod 0777 ${binary_dir}"/"${binary_name}

# Add execute environment var
env_status=`cat ~/.bashrc | grep ${binary_dir}`

if [ -z "${env_status}" ];then
	echo "env is not set, create it"
	echo "export PATH=\$PATH:${binary_dir}" >> ~/.bashrc
fi

echo "sucessfully"
