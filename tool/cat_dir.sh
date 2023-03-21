#!/bin/bash

if [ -n "$1" ]; then
	dir=`readlink -f $1`
else
	dir=`pwd`
fi

echo "[INFO] Current working dir is: $dir"

for f in `ls $dir`; do 
	file=${dir}/$f
	if [ -f ${file}  ]; then 
		if [ -r ${file} ]; then 
			linecount=`wc -l ${file} | awk '{print $1}'`
			echo "[INFO] ${file} [$linecount]:"; 
			cat ${file}; 
			if [ -n "$linecount" ]; then
				if [ $linecount -gt 0 ]; then
					echo ""
				fi
			fi
		fi; 
	fi;  
done

