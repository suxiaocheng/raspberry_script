#!/bin/bash

binary_name=".tmux.conf"
binary_dir="$HOME"

# it takes 2 arguments
# returns:
#  0 if v1 (1st argument) and v2 (2nd argument) are the same
#  1 if v1 is less than v2
#  2 if v1 is greater than v2
version_cmp() {
    local V1 V2 VN x
    [[ ! $1 =~ ^[0-9]+(\.[0-9]+)*$ ]] && die "Wrong version format!"
    [[ ! $2 =~ ^[0-9]+(\.[0-9]+)*$ ]] && die "Wrong version format!"

    V1=( $(echo $1 | tr '.' ' ') )
    V2=( $(echo $2 | tr '.' ' ') )
    VN=${#V1[@]}
    [[ $VN -lt ${#V2[@]} ]] && VN=${#V2[@]}

    for ((x = 0; x < $VN; x++)); do
        [[ ${V1[x]} -lt ${V2[x]} ]] && return 1
        [[ ${V1[x]} -gt ${V2[x]} ]] && return 2
    done 

    return 0
}

die() {
    [[ -n "$1" ]] && echo -e "\nERROR: $1\n" >&2
    # send die signal to the main process
    [[ $BASHPID -ne $$ ]] && kill -USR2 $$
    # we don't need to call cleanup because it's traped on EXIT
    exit 1
}

if [ ! -d "${binary_dir}" ]; then
	echo "${binary_dir} directory is not exist"
	mkdir "${binary_dir}"
fi

if [ ! -f ${binary_dir}"/"${binary_name} ]; then
	echo "${binary_name} is not exist"
fi

tmux_version=`tmux -V|tmux -V|awk '{print $2}'`

version_cmp $tmux_version 2.3
if [[ ! "$?" -eq 2 ]]; then
	source_binary_name=$binary_name
else
	source_binary_name=$binary_name"_2.6"
fi

cp ${source_binary_name} ${binary_dir}"/"${binary_name}
chmod 0777 ${binary_dir}"/"${binary_name}

echo "sucessfully"
