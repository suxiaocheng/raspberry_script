#!/bin/sh  
PID=$(cat /var/run/ReportTime.pid)  
kill -9 $PID 
