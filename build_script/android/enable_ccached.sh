#!/bin/bash

export USE_CCACHE=1

export CCACHE_DIR=$(pwd)

echo "Setting ccache dir to ${CCACHE_DIR}"

CCACHE_SCRIPT=$(which ccache)
if [ -f ${CCACHE_SCRIPT} -a -x ${CCACHE_SCRIPT} ]; then
	${CCACHE_SCRIPT} -M 30G 
else
	echo "[ERROR] cached file ${CCACHE_SCRIPT} is not exit!!!"
	exit 1
fi
