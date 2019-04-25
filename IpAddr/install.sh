#!/bin/sh

#!/bin/bash

die() {
    [[ -n "$1" ]] && echo -e "\nERROR: $1\n" >&2
    # send die signal to the main process
    [[ $BASHPID -ne $$ ]] && kill -USR2 $$
    # we don't need to call cleanup because it's traped on EXIT
    exit 1
}

check_exit_code() {
        if [ "$?" -ne "0" ]; then
                echo "program exit unnormal $1"
                exit 1
        fi  
}

EXEC_SCRIPT_DIR="/etc/IpAddr"
START_SCRIPT="start.sh"
STOP_SCRIPT="stop.sh"

SERVICE=ipaddr.service
JAVA_PACKAGE="IpAddr.jar"
JAVA_PACKAGE_DIR="/usr/local/jar/"

if [ ! -d "${JAVA_PACKAGE_DIR}" ]; then
	sudo mkdir -p ${JAVA_PACKAGE_DIR}
	check_exit_code "create ${JAVA_PACKAGE_DIR} fail"
fi

sudo cp ${JAVA_PACKAGE} ${JAVA_PACKAGE_DIR}
check_exit_code "Copy ${JAVA_PACKAGE} fail"

sudo chmod 0755 "${JAVA_PACKAGE_DIR}""${JAVA_PACKAGE}"
check_exit_code "chmod ${JAVA_PACKAGE} fail"

if [ -d "/usr/lib/systemd/system/" ]; then
	sudo cp $SERVICE /lib/systemd/system/
elif [ -d "/etc/systemd/system" ]; then
        sudo cp $SERVICE /etc/systemd/system/
else
        echo "Install service fail"
        exit 1
fi
check_exit_code "copy service fail"

if [ ! -d ${EXEC_SCRIPT_DIR} ]; then
        sudo mkdir ${EXEC_SCRIPT_DIR}
        check_exit_code "mkdir ${EXEC_SCRIPT_DIR} fail"
fi

sudo cp ${START_SCRIPT} ${STOP_SCRIPT} ${EXEC_SCRIPT_DIR}
check_exit_code "copy ${START_SCRIPT} ${STOP_SCRIPT} to ${EXEC_SCRIPT_DIR} fail"

sudo systemctl enable $SERVICE
sudo systemctl start $SERVICE
sync


