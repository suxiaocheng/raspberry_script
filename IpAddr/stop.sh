#!/bin/sh  
PID=$(cat /var/run/IpAddr.pid)  
kill -9 $PID 
