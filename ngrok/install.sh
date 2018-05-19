
systemctl stop ngrok.service

cp ngrok.service /usr/lib/systemd/system/
sync

systemctl enable ngrok.service
systemctl start ngrok.service


