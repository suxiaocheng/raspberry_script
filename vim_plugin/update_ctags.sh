#!/bin/bash

# Record the update_taglist to file
CSCOPE_SCAN_FILE_LIST=~/.cscope_file.list
CSCOPE_SCAN_FILE_FOUND=0
CURRENT_PATH=`pwd`
if [ -f ${CSCOPE_SCAN_FILE_LIST} ]; then
	while read line
	do
		# echo $line
		if [ "$line" == "${CURRENT_PATH}" ]; then
			echo "Found match"
			CSCOPE_SCAN_FILE_FOUND=1
		fi
	done < ${CSCOPE_SCAN_FILE_LIST}
fi

CSCOPE_FILES=cscope.files

rm -rf ${CSCOPE_FILES}

find . -name "*.[h|c]" >> $CSCOPE_FILES
find . -name "*.cpp" >> $CSCOPE_FILES

if [ ! -f $CSCOPE_FILES ]; then
	echo "[ERR] $CSCOPE_FILES is not exist!!!"
	exit 1
fi

valid_file=0
while read line
do
	# echo $line
	ls_status=`ls -l ${line}`
	# echo "${line} is ${ls_status}"
	if [ "${ls_status:0:1}" = "l" ]; then
		echo "[INFO] ${line} is a soft link file"
	else
		echo ${line} >> ${CSCOPE_FILES}$$
		valid_file=$((valid_file+1))
	fi
done < ${CSCOPE_FILES}

# echo "temp file is: ${CSCOPE_FILES}$$"
echo "[INFO] Valid c/cpp/header file count: ${valid_file}"
if [ ${valid_file} -gt 0 ]; then
	rm ${CSCOPE_FILES}
	mv ${CSCOPE_FILES}$$ ${CSCOPE_FILES}
else
	rm -rf ${CSCOPE_FILES} ${CSCOPE_FILES}$$
	echo "[ERR] No valid c/cpp/header file is found"
	exit 1
fi

rm -rf cscope.out cscope.in.out cscope.po.out

cscope -Rbkq -i $CSCOPE_FILES
if [ $? != 0 ]; then
	echo "[ERR] cscope is execute fail"
	exit 2
fi

ctags --langmap=C++:+.hal -R
if [ $? != 0 ]; then
	echo "[ERR] ctagsis execute fail"
	exit 3
fi


if [ "${CSCOPE_SCAN_FILE_FOUND}" == "0" ]; then
	echo "Add to file ${CSCOPE_SCAN_FILE_LIST}"
	echo ${CURRENT_PATH} >> ${CSCOPE_SCAN_FILE_LIST}
fi

echo "[INFO] Sucessfully"
