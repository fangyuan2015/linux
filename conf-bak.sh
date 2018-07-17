#!/bin/bash
#Description:This scripts use for backup the application config file,include nginx,mysql,tomcat,redis,rabbitmq
#Version:0.1
#Auth:546219618@qq.com
#date:2018/07/17

NGINX_CONF=/usr/local/nginx/conf/nginx.conf
MYSQL_CONF=/etc/my.cnf
TOMCAT_USER=/SSY/tomcat8/conf/tomcat-users.xml
#config tomcat web login account
TOMCAT_SERVER=/SSY/tomcat8/conf/server.xml
TOMCAT_UP=/SSY/tomcat8/webapps/manager/WEB-INF/web.xml
#config upload limit
REDIS_CONF=/etc/redis.conf

HOSTNAME=`hostname`
BAK_LOG=/var/log/configbak.log
DATE=`date +%F`
BAK_DIR=/SSY/Backup/config/${HOSTNAME}/${DATE}

if [ ! -d ${BAK_DIR} ];then
    	mkdir -p ${BAK_DIR}
fi

if [ ! -f ${BAK_LOG} ];then
    	touch ${BAK_LOG}
fi
#create backup dir and log file

for i in ${NGINX_CONF} ${MYSQL_CONF} ${TOMCAT_USER} ${TOMCAT_SERVER} ${TOMCAT_UP} ${REDIS_CONF}
do
	if [ -f $i ];then
	    /bin/cp $i ${BAK_DIR}/
	    echo "finish nginx config ${DATE}" >> ${BAK_LOG}
	else
	    echo "There was no $i ${DATE}" >> ${BAK_LOG}

	fi
done

echo "The backup directory ${BAK_DIR} content"
ls -lrt ${BAK_DIR}









