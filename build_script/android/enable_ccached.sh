#!/bin/bash

export USE_CCACHE=1

export CCACHE_DIR=$(pwd)

echo "Setting ccache dir to ${CCACHE_DIR}"

CCACHE_SCRIPT=prebuilt/linux-x86/ccache/ccache
if [ -f -x ${CCACHE_SCRIPT} ]; then
	${CCACHE_SCRIPT} -M 30G 
else
	echo "[ERROR] cached file ${CCACHE_SCRIPT} is not exit!!!"
	exit 1
fi
