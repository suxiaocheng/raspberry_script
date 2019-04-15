#!/bin/sh

check_str="animal"

# Add execute environment var
env_status=`cat ~/.bashrc | grep ${check_str}`

if [ -z "${env_status}" ];then
	echo "${check_str} is not set, insert it"
	cp ~/.bashrc ~/.bashrc.bak
	echo "if [ \"\${0}\" = \"-bash\" ]; then
 echo \"　　　　　　　 ┏┓       ┏┓+ +\"
 echo \"　　　　　　　┏┛┻━━━━━━━┛┻┓ + +\"
 echo \"　　　　　　　┃　　　　　　 ┃\"
 echo \"　　　　　　　┃　　　━　　　┃ ++ + + +\"
 echo \"　　　　　　 █████━█████  ┃+\"
 echo \"　　　　　　　┃　　　　　　 ┃ +\"
 echo \"　　　　　　　┃　　　┻　　　┃\"
 echo \"　　　　　　　┃　　　　　　 ┃ + +\"
 echo \"　　　　　　　┗━━┓　　　 ┏━┛\"
 echo \"                 ┃　　  ┃\"
 echo \"　　　　　　　　　┃　　  ┃ + + + +\"
 echo \"　　　　　　　　　┃　　　┃　Code is far away from bug with the animal protecting\"
 echo \"　　　　　　　　　┃　　　┃ +              神兽保佑,代码无bug\"
 echo \"　　　　　　　　　┃　　　┃\"
 echo \"　　　　　　　　　┃　　　┃　　+\"
 echo \"　　　　　　　　　┃　 　 ┗━━━┓ + +\"
 echo \"　　　　　　　　　┃ 　　　　　┣┓\"
 echo \"　　　　　　　　　┃ 　　　　　┏┛\"
 echo \"　　　　　　　　　┗┓┓┏━━━┳┓┏┛ + + + +\"
 echo \"　　　　　　　　　 ┃┫┫　 ┃┫┫\"
 echo \"　　　　　　　　　 ┗┻┛　 ┗┻┛+ + + +\"
fi" >> ~/.bashrc
fi

echo "sucessfully"
