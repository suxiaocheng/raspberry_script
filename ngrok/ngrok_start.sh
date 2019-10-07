#!/bin/bash

ngrok="/usr/bin/ngrok"

if [ -f $ngrok ]; then
        # export HOME=/home/pi
        $ngrok tcp 22 -log=stdout -log-level=debug &
	# $ngrok http 80 -log=stdout -log-level=debug &
else
        echo "File not found: " $ngrok
fi

