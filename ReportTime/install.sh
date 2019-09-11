#!/bin/bash

SERVICE_NAME=report_time.service
SERVICE_ROOT_NAME=report_time_root.service
START_SCRIPT_NAME=start.sh
STOP_SCRIPT_NAME=stop.sh
SED_STRING="s/myuser/${USER}/g"

sed ${SED_STRING} ${SERVICE_NAME}.tmpl > ${SERVICE_NAME}
sed ${SED_STRING} ${SERVICE_ROOT_NAME}.tmpl > ${SERVICE_ROOT_NAME}
sed ${SED_STRING} ${START_SCRIPT_NAME}.tmpl > ${START_SCRIPT_NAME}
sed ${SED_STRING} ${STOP_SCRIPT_NAME}.tmpl > ${STOP_SCRIPT_NAME}

chmod +x ${SERVICE_NAME}
chmod +x ${SERVICE_ROOT_NAME}
chmod +x ${START_SCRIPT_NAME}
chmod +x ${STOP_SCRIPT_NAME}

systemctl --user stop ${SERVICE_NAME}
if [ $? != 0 ]; then
	echo "stop ${SERVICE_NAME} fail, try non user mode"
	sudo systemctl stop ${SERVICE_ROOT_NAME}
fi

umask 022
unset cp


if [ -d "${HOME}/.config/systemd/user" ]; then
	echo "user mode"
	cp -r ../ReportTime ~
	chmod +x ~/ReportTime/${START_SCRIPT_NAME}
	chmod +x ~/ReportTime/${STOP_SCRIPT_NAME}
	cp ${SERVICE_NAME} ~/.config/systemd/user/
	systemctl --user daemon-reload
	systemctl --user enable ${SERVICE_NAME}
	systemctl --user start ${SERVICE_NAME}
	sync
	exit 0
elif [ -d "/usr/lib/systemd/system/" ]; then
	sudo cp -r ../ReportTime /root
	sudo chmod +x /root/ReportTime/${START_SCRIPT_NAME}
	sudo chmod +x /root/ReportTime/${STOP_SCRIPT_NAME}
        sudo cp ${SERVICE_ROOT_NAME} /usr/lib/systemd/system/
	systemctl daemon-reload
elif [ -d "/etc/systemd/system" ]; then
	sudo cp -r ../ReportTime /root
	sudo chmod +x /root/ReportTime/${START_SCRIPT_NAME}
	sudo chmod +x /root/ReportTime/${STOP_SCRIPT_NAME}
        sudo cp ${SERVICE_ROOT_NAME} /etc/systemd/system/
	systemctl daemon-reload
else
        echo "Install service[${SERVICE_NAME}] fail"
        exit 1
fi

echo "non user mode"

sudo systemctl enable ${SERVICE_ROOT_NAME}
sudo systemctl start ${SERVICE_ROOT_NAME}
sync


