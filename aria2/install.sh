#!/bin/bash

source ../basic/helper.sh

PROGRAM_NAME="aria2"
PROGRAM_STATUS=`which ${PROGRAM_NAME}"c"`
SERVICE_NAME="aria2.service"

if [ -z $PROGRAM_STATUS ]; then
	sudo apt install -y $PROGRAM_NAME
	if [[ "$?" -ne 0 ]]; then
		echo "${PROGRAM_NAME} install fail"
		exit 1
	else
		echo "${PROGRAM_NAME} is not exist, install ok"
	fi
fi

sudo apt install -y nodejs screen
if [[ "$?" -ne 0 ]]; then
	echo "nodejs and screen install fail"
	exit 1
else
	echo "nodejs install ok"
fi

binary_dir="/etc/aria2"
binary_name="aria2.conf"

SED_STRING="s/myuser/${USER}/g"
sed ${SED_STRING} ${binary_name}.tmpl > ${binary_name}

if [ ! -d "${binary_dir}" ]; then
	echo "${binary_dir} directory is not exist"
	sudo mkdir -p "${binary_dir}"
fi
sudo cp ${binary_name} ${binary_dir}"/"${binary_name}
sudo chmod 0777 ${binary_dir}"/"${binary_name}

if [ ! -d "${HOME}/aria2" ]; then
	mkdir ${HOME}/aria2
	cp aria2.session ${HOME}/aria2/
fi

cp start_webui.sh  ${HOME}/bin/

stop_service ${SERVICE_NAME}

install_and_start_service ${SERVICE_NAME}

echo "[INFO] sucesfully"
