#!/bin/bash

source ../basic/helper.sh

EXEC_SCRIPT_DIR="/etc/IpAddr"
START_SCRIPT="start.sh"
STOP_SCRIPT="stop.sh"

SERVICE=ipaddr.service
JAVA_PACKAGE="IpAddr.jar"
JAVA_PACKAGE_DIR="/usr/local/jar/"

stop_service ${SERVICE}

if [ ! -d "${JAVA_PACKAGE_DIR}" ]; then
	sudo install -d ${JAVA_PACKAGE_DIR}
	check_exit_code "create ${JAVA_PACKAGE_DIR} fail"
fi

sudo install -m 0755 -D ${JAVA_PACKAGE} ${JAVA_PACKAGE_DIR}/${JAVA_PACKAGE}
check_exit_code "Copy ${JAVA_PACKAGE} fail"

sudo install -m 0755 -D ${START_SCRIPT} ${EXEC_SCRIPT_DIR}/${START_SCRIPT}
check_exit_code "copy ${START_SCRIPT} to ${EXEC_SCRIPT_DIR} fail"
sudo install -m 0755 -D ${STOP_SCRIPT} ${EXEC_SCRIPT_DIR}/${STOP_SCRIPT}
check_exit_code "copy ${STOP_SCRIPT} to ${EXEC_SCRIPT_DIR} fail"

install_and_start_service ${SERVICE}

echo "[INFO] sucesfully"

