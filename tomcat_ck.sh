#!/bin/bash
TOMCAT_PORT=`netstat -ant|grep 8080|grep -v grep|wc -l`
TOMCAT_PATH=/root/apache-tomcat-8.5.11/bin
TOMCAT_START=${TOMCAT_PATH}/startup.sh
if [ ${TOMCAT_PORT} -lt 1 ];then
    /bin/sh ${TOMCAT_START} >/dev/null 2>&1
fi
