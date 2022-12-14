#!/bin/bash

echo "arg num: $#"

if [ $# -ge 1 ];then
	need_quit=1
fi

# kill previous md5sum process
PRE_PROCESS=`ps -aux |grep md5sum |grep -v "grep"| awk '{print $2}'`

for pid in ${PRE_PROCESS}
do
	echo "Kill process $pid"
	kill $pid
done

if [ ! -z "${need_quit}" ]; then
	exit 0
fi

NUM=`cat /proc/cpuinfo  | grep processor |wc -l`

if [ -z "${NUM}" ]; then
	NUM=4
fi

count=0

while ((count < NUM))
do
	echo "create stress process $count.(With lowest proiroty)"
	nice -n 19 md5sum /dev/zero &
	count=$((count+1))
done
