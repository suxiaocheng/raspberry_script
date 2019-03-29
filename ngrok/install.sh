
systemctl stop ngrok.service

cp bin/ngrok /usr/bin/

if [ $? != "0" ]; then
	echo "Copy binary to /usr/bin fail"
	exit 0
fi

cp ngrok.service /usr/lib/systemd/system/
sync

systemctl enable ngrok.service
systemctl start ngrok.service


