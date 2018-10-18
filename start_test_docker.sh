#!/bin/bash
#description:This scripts use for start all app containers and restart web war packages
#data: 2018/10/17
sleep 15
#等待docker daemon 服务端启动

docker start D-LT-MySQL-107 D-LT-MySQL-106 D-LT-RabbitMQ-105 D-LT-Redis-104 D-LT-MySQL-103 D-LT-MySQL-101 D-LT-MySQL-108
#在启动服务器后，启动所有的应用容器

sleep 10
docker start D-LT-Nginx-Tomcat-102 D-LT-Nginx-Tomcat-100
#待数据库容器启动完全后再启动web容器

sleep 10
echo "sleep 10 seconds ,wait container start"

docker exec -i D-LT-Nginx-Tomcat-100 sh /SSY/war_start_byself.sh
#重启所有wdzh的web容器上的war包

