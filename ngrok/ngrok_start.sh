#!/bin/sh

ngrok="/home/pi/program/ngrok/ngrok"

if [ -f $ngrok ]; then
        export HOME=/home/pi
        $ngrok tcp 22 -log=stdout -log-level=debug &
else
        echo "File not found: " $ngrok
fi

