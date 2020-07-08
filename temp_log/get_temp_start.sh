#!/bin/bash

/etc/temp_monitor/get_temp.sh &

echo $! > /var/run/temperature.pid
