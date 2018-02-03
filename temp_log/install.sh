
systemctl stop get_temp.service

cp get_temp.service /usr/lib/systemd/system/
mkdir -p /home/pi/temperature/
cp get_temp.sh get_temp_start.sh get_temp_stop.sh /home/pi/temperature/
sync

systemctl enable get_temp.service
systemctl start get_temp.service


