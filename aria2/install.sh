
systemctl stop aria2.service

cp aria2.service /usr/lib/systemd/system/
sync

systemctl enable aria2.service
systemctl start aria2.service


