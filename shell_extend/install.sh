#!/bin/bash

check_str_list[0]="c='clear'"
check_str_list[1]="g='git log --oneline --graph --decorate'"
check_str_list[2]="i='indent -npro -kr -i8 -ts8 -sob -l80 -ss -ncs'"
check_str_list[3]="m='mount|less'"
check_str_list[4]="s='source ~/.bashrc'"
check_str_list[5]="t='tmux attach || tmux'"
check_str_list[6]="u='update_ctags.sh'"
check_str_list[7]="p='pwd'"
check_str_list[8]="z='top -d 1'"
check_str_list[9]="cp='rsync -av --info=progress2'"

check_export_enhanced_list[0]="HISTTIMEFORMAT=\"[%Y-%m-%d %H:%M:%S] \""

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

insert_str_export() {
	# Add execute environment var
	compare_str=${1%=*}
	# echo "compare str is ${compare_str}"
	env_status=`cat ${target_dir}${target_file} | grep "${compare_str}"`

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

for ((i=0; i< ${#check_export_enhanced_list[*]}; i++)); do
	echo ${check_export_enhanced_list[i]}

	
	insert_str_export "${check_export_enhanced_list[i]}" "export ${check_export_enhanced_list[i]}" 
done

echo "sucessfully"
