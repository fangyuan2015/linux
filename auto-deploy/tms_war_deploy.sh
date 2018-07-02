#!/bin/bash
#Filename：tms_war_deploy.sh
#description：此版本暂定用于开发测试和预发布环境发布tms.war包
#date:2018/5/18

DATE=`date +%F`
DEPLOY_DIR=/SSY/Deploy/$DATE
BACKUP_DIR=/SSY/Backup/$DATE
OLDWAR_DIR=/SSY/tomcat8/webapps
TEMP_DIR=/SSY/Deploy
LOG_DIR=/var/log/war-deploy

if [ ! -d ${DEPLOY_DIR} ];then
        mkdir -p ${DEPLOY_DIR}
fi

if [ ! -d ${BACKUP_DIR} ];then
        mkdir -p ${BACKUP_DIR}
fi


if [ ! -d ${TEMP_DIR} ];then
        mkdir -p ${TEMP_DIR}
fi


if [ ! -d ${LOG_DIR} ];then
        mkdir -p ${LOG_DIR}
fi
#定义和创建更新与备份等目录

rm -f ${DEPLOY_DIR}/*.war
ls ${DEPLOY_DIR}
echo "删除上次部署过程遗留的war包"

/bin/cp ${TEMP_DIR}/*.war ${DEPLOY_DIR}
#将Jenkins中上传目录中的war包拷贝到部署目录中

>/SSY/tomcat8/logs/catalina.out
#清空tomcat日志
>${LOG_DIR}/success_deploy.log
>${LOG_DIR}/fail_deploy.log
#清空上次war包部署过程产生的日志

TOMCAT_PID=`ps -ef|grep -v grep |grep tomcat8|awk '{print $2}'`
TOMCAT_PID_NUM=`ps -ef|grep -v grep |grep tomcat8|awk '{print $2}'|wc -l`
if [ ${TOMCAT_PID_NUM} -ge 1 ];then
	kill -9 ${TOMCAT_PID}
	#停止tomcat进程
	echo "tomcat服务停止"
else
	echo "注意：没有发现可以终止的tomcat进程"
fi

#if [ `ls -l ${BACKUP_DIR}/*.war|wc -l` -ge 1 ];then
#        echo "是第二次执行脚本吗，已经存在如下备份文件，无需重复备份"
#        ls ${BACKUP_DIR}
#else
#        if [ `ls -l /SSY/tomcat8/webapps/*.war|wc -l` -ge 1 ];then
/bin/cp -n /SSY/tomcat8/webapps/*.war ${BACKUP_DIR}
echo "完成war包的备份，备份路径如下：${BACKUP_DIR}"
echo "备份war包内容如下："
ls ${BACKUP_DIR}
#    else
#                echo "/SSY/tomcat8/webapps dir has no war file"
#        fi
#fi
#备份/SSY/tomcat8/webapps/*.war 包

echo "开始清空 ${OLDWAR_DIR}目录中的war包及相关文件夹"
for j in `ls -l ${OLDWAR_DIR}/*.war|awk '{print $9}'|awk -F '/' '{print $5}'|awk -F '.' '{print $1}'`
do
	/bin/cp ${OLDWAR_DIR}/$j ${LOG_DIR}
        rm -rf ${OLDWAR_DIR}/$j
        rm -f ${OLDWAR_DIR}/*.war
done
echo "完成旧包及文件夹的清理，${OLDWAR_DIR} 目录内容如下："
ls ${OLDWAR_DIR}
#请空OLDWAR_DIR=/SSY/tomcat8/webapps目录中旧的war包及相关文件夹

echo "开始启动tomcat服务"
/etc/init.d/tomcat start
echo "tomcat 服务启动完成"

echo "开始进行tms.war包的部署"
/bin/cp ${DEPLOY_DIR}/tms.war ${OLDWAR_DIR}
seconds_left=240
while [ $seconds_left -gt 0 ]
do
	sleep 5
	com_log=`grep "tms has finished" /SSY/tmcat8/logs/catalina.out`
	com_log_item=`grep "tms has finished" /SSY/tomcat8/logs/catalina.out|wc -l`
	com_error_log=`egrep -i "ERROR|WARNING" /SSY/tomcat8/logs/catalina.out`
	com_error_log_item=`egrep -i "ERROR|WARNING" /SSY/tomcat8/logs/catalina.out|wc -l`
	if [ $com_error_log_item -ge 1 ];then
		echo "------------------------------"
		echo "take care error log:"
		echo $HOSTNAME >>${LOG_DIR}/fail_deploy.log
		echo $com_error_log
		echo "tms has error" >>${LOG_DIR}/fail_deploy.log
		cat /SSY/tomcat8/logs/catalina.out|egrep -v  "DEBUG" >>${LOG_DIR}/fail_deploy.log
		break
	elif [ $com_log_item -ge 1 ];then
		echo $com_log
		echo $HOSTNAME>>${LOG_DIR}/success_deploy.log
		echo $com_log >>${LOG_DIR}/success_deploy.log
		#将成功部署war包日志记录
		echo "--------------------------------"
		echo "tms success deploy complete "
		echo "--------------------------------"
		break
	else
		echo "tms deploying,please wait "
		seconds_left=$(($seconds_left - 5))
		if [ $seconds_left -lt 0 ];then
			echo "请检查WEB页面，以确认部署是否成功"
			break
		else
			continue
		fi
					
	fi
		
		
done

rm -f ${TEMP_DIR}/*.war
#清空中转文件夹中war包

echo "Deploy process finished"
echo " "
echo "-----------------------------"
echo "Maybe Deploy faile war log: "
if [ -s ${LOG_DIR}/fail_deploy.log ];then
        cat ${LOG_DIR}/fail_deploy.log
else
        echo "部署过程中未检测到部署失败日志内容，初步确定包均以部署成功"
fi

echo "-----------------------------"
echo "Deploy success war list"
cat ${LOG_DIR}/success_deploy.log

