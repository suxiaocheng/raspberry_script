#!/bin/bash
PID=$(cat /var/run/temperature.pid)  
kill -9 $PID 
