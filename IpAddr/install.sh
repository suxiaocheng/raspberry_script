#!/bin/sh

SERVICE=ipaddr.service

cp -r ../IpAddr ~

sudo cp $SERVICE /lib/systemd/system/
sudo systemctl enable $SERVICE
sudo systemctl start $SERVICE
sync


