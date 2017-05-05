#!/bin/bash
[ `rpm -qa nmap|wc -l` -lt 1 ] && yum install nmap -y &>/dev/null
if [ `nmap 192.168.72.138 -p 80 2>/dev/null|grep open|wc -l` -gt 0 ];then
    echo "The nginx is running"
else
    echo "The nginx is stop"
    systemctl start nginx
fi
