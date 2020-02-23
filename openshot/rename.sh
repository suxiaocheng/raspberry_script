#!/bin/bash

work_dir=$1
pattern=$2
if [ -z $1 ]; then
	work_dir="."
fi

if [ ! -d ${work_dir=} ]; then
	echo "[ERROR] working dir(${work_dir}) is not directory"
	exit 1
fi

echo -n "[INFO] Working dir: ${work_dir}"
if [ -z ${pattern} ]; then
	echo ", pattern is ${pattern}"
else
	echo ""
fi

file_list=`ls ${work_dir}"/"${pattern}`
count=0

for file in ${file_list}; do
	new_file=`echo ${count}|awk '{printf("openshot-%06d.jpg", $1)}'`
	echo "rename ${file} -> ${new_file}"
	mv ${work_dir}"/"${file} ${work_dir}"/"${new_file}
	count=$((count+1))
done

echo "[INFO] sucessfully rename ${count} file"

