#!/bin/sh

cp -r ../ReportTime ~

sudo cp report_time.service /lib/systemd/system/
sudo systemctl enable report_time.service
sudo systemctl start report_time.service
sync


