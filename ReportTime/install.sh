#!/bin/sh

SERVICE_NAME=report_time.service
SED_STRING="s/myuser/${USER}/g"

sed ${SED_STRING} ${SERVICE_NAME}.tmpl > ${SERVICE_NAME}
exit 0

sudo systemctl stop ${SERVICE_NAME}

cp -r ../ReportTime ~

if [ -d "/usr/lib/systemd/system/" ]; then
        mv ${SERVICE_NAME} /usr/lib/systemd/system/
elif [ -d "/etc/systemd/system" ]; then
        mv ${SERVICE_NAME} /etc/systemd/system/
else
        echo "Install service[${SERVICE_NAME}] fail"
        exit 1
fi

sudo systemctl enable ${SERVICE_NAME}
sudo systemctl start ${SERVICE_NAME}
sync


