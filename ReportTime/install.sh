#!/bin/sh

SERVICE_NAME=report_time.service
START_SCRIPT_NAME=start.sh
STOP_SCRIPT_NAME=stop.sh
SED_STRING="s/myuser/${USER}/g"

sed ${SED_STRING} ${SERVICE_NAME}.tmpl > ${SERVICE_NAME}
sed ${SED_STRING} ${START_SCRIPT_NAME}.tmpl > ${START_SCRIPT_NAME}
sed ${SED_STRING} ${STOP_SCRIPT_NAME}.tmpl > ${STOP_SCRIPT_NAME}

sudo systemctl stop ${SERVICE_NAME}

cp -r ../ReportTime ~

if [ -d "/usr/lib/systemd/system/" ]; then
        sudo mv ${SERVICE_NAME} /usr/lib/systemd/system/
elif [ -d "/etc/systemd/system" ]; then
        sudo mv ${SERVICE_NAME} /etc/systemd/system/
else
        echo "Install service[${SERVICE_NAME}] fail"
        exit 1
fi

sudo systemctl enable ${SERVICE_NAME}
sudo systemctl start ${SERVICE_NAME}
sync


