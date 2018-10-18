#!/bin/bash
#description:This scripts use for restart all war packages,and it shoud storage in web container
#date: 2018/10/17
#qq: 546219618
sleep 10
/bin/cp /SSY/tomcat8/webapps/*.war /tmp
/bin/rm -f /SSY/tomcat8/webapps/*.war
rm -rf /tmp/{cas,cms,crm,csms,dir,dir_ssy,csr,ims,iss,lms,lss,mns,mss,rss,tms,edge}
            
/bin/mv /SSY/tomcat8/webapps/{cas,cms,crm,csms,dir,dir_ssy,ims,iss,lms,lss,mns,mss,rss,tms,csr,edge} /tmp
#将所有war包及相关文件夹移动到临时目录

kill -9 `ps -ef|grep tomcat8|grep -v grep|awk '{print $2}'`
/etc/init.d/tomcat start
/bin/mv /tmp/tms.war /SSY/tomcat8/webapps/

sleep 60
#重启tomcat
#等待tms启动
echo "sleep finished"

/bin/cp /tmp/*.war /SSY/tomcat8/webapps/

#启动其他应用

