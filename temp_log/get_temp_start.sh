#!/bin/sh

/etc/temp_monitor/get_temp.sh &

echo $! > /var/run/temperature.pid
