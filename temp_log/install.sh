#!/bin/bash
source ../basic/helper.sh

SERVICE_NAME="get_temp.service"
SCRIPT_DIR="/etc/temp_monitor/"
START_SCRIPT="get_temp_start.sh"
STOP_SCRIPT="get_temp_stop.sh"
EXEC_SCRIPT="get_temp.sh"

stop_service ${SERVICE_NAME}

sudo install -m 0755 -D ${START_SCRIPT} ${SCRIPT_DIR}${START_SCRIPT}
sudo install -m 0755 -D ${STOP_SCRIPT} ${SCRIPT_DIR}${STOP_SCRIPT}
sudo install -m 0755 -D ${EXEC_SCRIPT} ${SCRIPT_DIR}${EXEC_SCRIPT}

install_and_start_service ${SERVICE_NAME}

echo "[INFO] sucessfully"
