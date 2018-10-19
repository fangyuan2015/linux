#!/bin/bash
if [ ! -f /var/log/azure_port.log ];then
    touch /var/log/azure_port.log
fi

nmap 42.159.234.230 -p1-65535 >> /var/log/azure_port.log
#生产环境微贷租户
nmap 139.219.232.241 -p1-65535 >> /var/log/azure_port.log
#生产环境小富和全局服务
nmap 42.159.233.238 -p1-65535 >> /var/log/azure_port.log
#预发布环境
