#!/bin/sh

/home/pi/temperature/get_temp.sh &

echo $! > /var/run/temperature.pid
