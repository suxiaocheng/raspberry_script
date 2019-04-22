#!/bin/bash

MACHINE=`uname -m`
TARGET_BIN_DIR="/usr/bin/"
SERVICE_NAME="ngrok.service"

EXEC_SCRIPT_DIR="/etc/ngrok"
START_SCRIPT="ngrok_start.sh"
STOP_SCRIPT="ngrok_stop.sh"

check_exit_code() {
        if [ "$?" -ne "0" ]; then
                echo "program exit unnormal $1"
                exit 1
        fi
}

systemctl stop ${SERVICE_NAME}

case ${MACHINE} in
	"x86_64")
		NGROK_BIN_ZIP="bin/ngrok-stable-linux-amd64.zip"
		;;
	"arm")
		NGROK_BIN_ZIP="bin/ngrok-stable-linux-arm.zip"
		;;
	*)
		NGROK_BIN_ZIP=""
		echo "unknow machine type ${MACHINE}"
		exit 1
		;;
esac

unzip -o ${NGROK_BIN_ZIP} -d ${TARGET_BIN_DIR}
check_exit_code "unzip ${NGROK_BIN_ZIP} fail"

case ${MACHINE} in
	"x86_64")
		${TARGET_BIN_DIR}"/ngrok" authtoken kii3Npj13Jqe6YvyiNHc_4Ze6EF138yALtKwLAdFaP
		;;
	"arm")
		${TARGET_BIN_DIR}"/ngrok" authtoken 88g4iyWLUGU44Dy5DSdis_7P8kh36yuiFtRDiYVayQh
		;;
esac
check_exit_code "create local token fail"


if [ -d "/usr/lib/systemd/system/" ]; then
	cp ${SERVICE_NAME} /usr/lib/systemd/system/
elif [ -d "/etc/systemd/system" ]; then
        cp ${SERVICE_NAME} /etc/systemd/system/
else
        echo "Install service fail"
        exit 1
fi

check_exit_code "copy service fail"

if [ ! -d ${EXEC_SCRIPT_DIR} ]; then
	mkdir ${EXEC_SCRIPT_DIR}
	check_exit_code "mkdir ${check_exit_code} fail"
fi

cp ${START_SCRIPT} ${STOP_SCRIPT} ${EXEC_SCRIPT_DIR}
check_exit_code "copy ${START_SCRIPT} ${STOP_SCRIPT} to ${EXEC_SCRIPT_DIR} fail"

systemctl enable ${SERVICE_NAME}
sync

systemctl start ${SERVICE_NAME}

echo "sucessfully install"


