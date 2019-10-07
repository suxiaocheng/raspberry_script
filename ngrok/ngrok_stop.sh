#!/bin/bash  
PID=`ps -aux |grep "ngrok_start.sh"| grep -v "grep" | awk '{print $2}' `
PID_PROGRAM=`ps -aux |grep "/home/pi/program/ngrok/ngrok "|grep -v "grep" | awk '{print $2}' `

# echo $PID  
# echo $PID_PROGRAM

if [ -n "$PID" ]; then
	echo "Going to kill process (${PID})"
        kill $PID
else
        echo "sh file is already exit"
fi

if [ -n "$PID_PROGRAM" ]; then
        kill -9 $PID_PROGRAM
else
        echo "bin file is already exit"
fi

