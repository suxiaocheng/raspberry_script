#!/bin/bash

WAVE_LIST=`ls *.wav`
count=0

check_exit_code() {
	if [ "$?" -ne "0" ]; then
		echo "[ERROR] program exit unnormal $1"
		exit 1
	fi
}

for file in $WAVE_LIST;
do
	new_file=${file%.*}".mp3"
	count=$((count+1))
	echo "${count}: convert $file to ${new_file}"
	rm -f $new_file
	ffmpeg -i $file -f mp3 ${new_file}
	check_exit_code "convert ${file} fail"
done

echo "[INFO] sucessfully convert all file"

