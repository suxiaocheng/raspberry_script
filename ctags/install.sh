#!/bin/sh

binary_name="update_ctags.sh"
binary_name_1="clear_ctags.sh"
binary_dir="$HOME""/bin"


CTAGS_PROGRAM=`which ctags`
CSCOPE_PROGRAM=`which cscope`

if [ -z "$CTAGS_PROGRAM" -a -z "$CSCOPE_PROGRAM" ]; then
	sudo apt install -y ctags cscope
	if [[ "$?" -ne "0" ]]; then
		echo "ctags install fail"
		exit 1
	else
		echo "ctags is not exist, install ok"
	fi
fi

if [ ! -d "${binary_dir}" ]; then
	echo "${binary_dir} directory is not exist"
	mkdir "${binary_dir}"
fi

if [ ! -f ${binary_dir}"/"${binary_name} ]; then
	echo "${binary_name} is not exist"
fi

if [ -f "${binary_dir}/.vimrc" ]; then
	echo "backup vimrc file"
	cp ${HOME}/.vimrc ${HOME}/.vimrc.bak
fi

cp ${binary_name} ${binary_dir}"/"${binary_name}
chmod 0777 ${binary_dir}"/"${binary_name}
cp ${binary_name_1} ${binary_dir}"/"${binary_name_1}
chmod 0777 ${binary_dir}"/"${binary_name_1}
cp .vimrc ${HOME}"/.vimrc"

# Add execute environment var
env_status=`cat ~/.bashrc | grep ${binary_dir}`

if [ -z "${env_status}" ];then
	echo "env is not set, create it"
	echo "export PATH=\$PATH:${binary_dir}" >> ~/.bashrc
fi

echo "sucessfully"
