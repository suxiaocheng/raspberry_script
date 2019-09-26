#!/bin/bash

PUTTY_DIR=${HOME}/.putty/sessions/

echo "[INFO] dir is ${PUTTY_DIR}"

if [ -d ${PUTTY_DIR} ]; then
	PUTTY_FILE_LIST=$(ls ${PUTTY_DIR})
fi

for str in ${PUTTY_FILE_LIST}; 
do
	echo ${str}
	PUTTY_FILE=${PUTTY_DIR}${str}
	cp ${PUTTY_DIR}${str} ./template
	echo "[INFO] putty config file(${PUTTY_FILE}) is copy to here"
	break
done


if [ ! -f ${PUTTY_DIR}${str} ]; then
	echo "[ERROR]: putty is not exist"
fi

