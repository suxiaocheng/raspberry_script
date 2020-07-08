#!/bin/bash

SESSION_NAME=node-server.js

SESSION_STATUS=$(ps -aux | grep ${SESSION_NAME} | grep -v "grep")

echo ${SESSION_STATUS}

if [ "${SESSION_STATUS}"0 != "0" ]; then
	echo "session[$SESSION_NAME] is already exist"
	exit 0
else
	echo "session[$SESSION_NAME] is not exist, going to create it"
fi

TARGET_DIR="${HOME}/program/webui-aria2/"

if [ -d "${TARGET_DIR}" ]; then
	cd ${TARGET_DIR}
	sudo screen -d -m nodejs node-server.js
else
	echo "${TARGET_DIR} is not install"
fi
