#!/bin/bash

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

PROGRAM_NAME="aria2"
PROGRAM_STATUS=`which ${PROGRAM_NAME}"c"`

if [ -z $PROGRAM_STATUS ]; then
	sudo apt install -y $PROGRAM_NAME
	if [[ "$?" -ne 0 ]]; then
		echo "${PROGRAM_NAME} install fail"
		exit 1
	else
		echo "${PROGRAM_NAME} is not exist, install ok"
	fi
fi

binary_dir="/etc/aria2"
binary_name="aria2.conf"
if [ ! -d "${binary_dir}" ]; then
	echo "${binary_dir} directory is not exist"
	sudo mkdir -p "${binary_dir}"
fi
sudo cp ${binary_name} ${binary_dir}"/"${binary_name}
sudo chmod 0777 ${binary_dir}"/"${binary_name}

sudo systemctl stop aria2.service

if [ -d "/usr/lib/systemd/system/" ]; then
	sudo cp aria2.service /usr/lib/systemd/system/
elif [ -d "/etc/systemd/system" ]; then
	sudo cp aria2.service /etc/systemd/system/
else
	echo "Install service fail"
	exit 1
fi

sudo systemctl enable aria2.service
sudo systemctl start aria2.service

sync
