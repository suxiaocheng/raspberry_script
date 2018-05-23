#!/bin/bash
# export JAVA_HOME=/usr/local/jdk1.8.0_131  
# export PATH=$JAVA_HOME/bin:$PATH  
TZ='Asia/Shanghai'
export TZ  
java -jar /home/pi/ReportTime/ReportTime.jar > /dev/null  &
echo $! > /var/run/ReportTime.pid
