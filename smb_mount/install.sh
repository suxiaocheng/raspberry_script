#!/bin/sh

binary_dir="$HOME""/bin"

SCRIPT_NAME="mount_server_raspberry.sh"

install -m 0755 -D ${SCRIPT_NAME} $binary_dir"/"${SCRIPT_NAME}

if [ "$?" -eq "0" ]; then
	echo "[INFO] sucessfully"
else
	echo "fail to copy file"
fi

