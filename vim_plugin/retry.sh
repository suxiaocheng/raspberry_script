#!/bin/bash

trap_quit() {
    if [ -n "$jobid" ]; then
        echo "[INFO] kill child thread $jobid"
        kill $jobid
        wait
    fi
    echo "[INFO] user quit ok"
    exit 0
}

get_time_offset() {
    end_time=`date +%s`

    # print finish used time
    used_time=$((end_time-start_time))

    used_hour=$((used_time/3600))
    used_minute=$((used_time%3600/60))
    used_second=$((used_time%60))

    echo "${used_hour}:${used_minute}:${used_second}"
}


trap trap_quit SIGTERM SIGKILL SIGINT
start_time=`date +%s`
count=0
if [ $# -gt 0 ]; then
	# echo "[INFO] arg is max than zero"
	if [ -n "$1" ]; then
		while [ true ]; do
			echo "[INFO] Execute command: "$1 " ,times "$count
			${1} &
            jobid=$!
            echo "[INFO] wait for ${jobid} to finish"
            wait ${jobid}

			if [ $? -eq 0 ]; then
				break;
            else
                echo "[INFO] cmd fail: $?, time: $(get_time_offset)"
			fi
			count=$((count+1))
			if [ $# -ge 2 ]; then
				if grep '^[[:digit:]]*$' <<< "$2";then
					echo "[INFO] Sleep $2"
					sleep $2
				fi
			fi
		done
	fi
else
	echo "[ERR] arg is null"
    exit 1
fi

echo "[INFO] cmd finish in $(get_time_offset)"

