#!/bin/bash

source ../basic/helper.sh

MACHINE=`uname -m`
TARGET_BIN_DIR="/usr/bin/"
SERVICE_NAME="ngrok.service"

EXEC_SCRIPT_DIR="/etc/ngrok"
START_SCRIPT="ngrok_start.sh"
STOP_SCRIPT="ngrok_stop.sh"

stop_service ${SERVICE_NAME}

case ${MACHINE} in
	"x86_64")
		NGROK_BIN_ZIP="bin/ngrok-stable-linux-amd64.zip"
		;;
	"armv7l")
		NGROK_BIN_ZIP="bin/ngrok-stable-linux-arm.zip"
		;;
	"armv6l")
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

sudo install -m 0755 -D ${START_SCRIPT} ${EXEC_SCRIPT_DIR}/${START_SCRIPT}
check_exit_code "copy ${START_SCRIPT} to ${EXEC_SCRIPT_DIR} fail"
sudo install -m 0755 -D ${STOP_SCRIPT} ${EXEC_SCRIPT_DIR}/${STOP_SCRIPT}
check_exit_code "copy ${STOP_SCRIPT} to ${EXEC_SCRIPT_DIR} fail"

install_and_start_service ${SERVICE_NAME}

echo "[INFO] sucessfully install"


