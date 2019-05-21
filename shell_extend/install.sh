#!/bin/bash

check_str_list[0]="c='clear'"
check_str_list[1]="p='pwd'"
check_str_list[2]="t='tmux attach'"

target_dir="${HOME}/"
backup_dir="backup/"
target_file=".bashrc"
#target_file="test.sh"


insert_str() {
	# Add execute environment var
	env_status=`cat ${target_dir}${target_file} | grep "${1}"`

	if [ -z "${env_status}" ];then
		echo "${1} is not set, insert it"
		echo "${2}" >> ${target_dir}${target_file}
	fi
}

check_exit_code() {
        if [ "$?" -ne "0" ]; then
                echo "program exit unnormal $1"
                exit 1
        fi
}

current_date=`date "+%y%m%d_%H%M%S"`

if [ ! -f ${target_dir}${target_file} ]; then
	touch ${target_dir}${target_file}
fi

if [ ! -d "${target_dir}${backup_dir}" ]; then
	mkdir -p ${target_dir}${backup_dir}
	check_exit_code "create ${target_dir}${backup_dir} fail"
fi

# backup current file
cp ${target_dir}${target_file} "${target_dir}${backup_dir}${target_file}.${current_date}"

echo "${#check_str_list[*]} command will be check"

for ((i=0; i< ${#check_str_list[*]}; i++)); do
	echo ${check_str_list[i]}
	
	insert_str "${check_str_list[i]}" "alias ${check_str_list[i]}" 
done

echo "sucessfully"
