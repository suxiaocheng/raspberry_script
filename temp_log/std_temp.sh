#!/bin/bash
TZ='Asia/Shanghai'
export TZ


i=1
DAY=`date | awk '{print $2}'`
MONTH=`date | awk '{print $3}'`
LOG_FILE=/home/pi/temperature/temp_"$DAY"_"$MONTH".log

while [ $i -le 1000 ]
do
	TEMP=`awk '{printf "%3.1f\n", $1/1000}' /sys/class/thermal/thermal_zone0/temp`
	DATE=`date | awk '{print $4}'`
	VAR=`date | awk '{print $2}'`
	LOAD=`cat /proc/loadavg`
	MEM=`free -h |grep Mem:|awk '{printf " %s %s %s %s",$4,$5,$6,$7}'`

	if [ "$DAY" != "$VAR" ]; then
		sync
		DAY=$VAR
		MONTH=`date | awk '{print $3}'`
		LOG_FILE=/home/pi/temperature/temp_"$DAY"_"$MONTH".log
	fi

	echo $DATE"" ""$TEMP" "$LOAD$MEM
	sleep 1
done

