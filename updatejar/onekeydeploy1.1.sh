#!/bin/bash
#Description:增加用户可以手动选择更新相关的war包功能
#Date: 2018/7/2

menu(){
echo -e "\033[41;36m 请选择正确数字来更新对应的包，注意：选择9将更新所有的jar包 \033[0m"
cat<<EOF

1.cusc-rnr-api-1.0.jar
2.cusc-rnr-service-1.0.jar
3.cusc-rnr-portal-1.0.jar
4.cusc-rnr-h5-1.0.jar
5.cusc-rnr-notifier-1.0.jar
6.cusc-rnr-admin-1.0.jar
7.cusc-rnr-task-1.0.jar
8.cusc-rnr-report-1.0.jar
9.update all *.jar 
0.exit the program
EOF
}
#提供用户更新jar包选择的菜单

update_jar(){
    scp -P 60068 root@172.24.103.58:/opt/apps/autobuild/rnr/$1 /opt/apps/
    echo $1>jar.txt
    #将jar包名写入jar.txt文件
    APP_NAME=cat jar.txt|awk -F "." '{print $1}'
    #获取jar包对应的应用名：applicationName
    PID=`ps -ef|grep -v grep|grep $1|awk '{print $2}'`
    #获取jar包的进程号pid
    kill -9 $PID
    nohup java $JAVA_OPTS -Dpinpoint.agentId=$PORTAL_AGENTID -Dpinpoint.applicationName=${APP_NAME} -Xms8G -Xmx8G  -jar $1 >/dev/null 2>&1 &
    PID=$!
    echo "cusc-rnr-portal is start ok, pid: $PID"
    #停止旧jar包，并启动新的的jar包，$1表示获取到的jar包名
}
#update_jar函数用于更新单个jar包的调用

while true
do
    menu
    echo -e "\033[41;36m ********************************************************** \033[0m"    
    read -p "Please input the right num: " NUM
    case $NUM in
        1)
	    echo "You are chose update: cusc-rnr-api-1.0.jar"
            update_jar cusc-rnr-api-1.0.jar
	    ;;
        2)
	    echo "You are chose update: cusc-rnr-service-1.0.jar"
            update_jar cusc-rnr-service-1.0.jar
	    ;;
	    
        3)
	    echo "You are chose update: cusc-rnr-portal-1.0.jar"
            update_jar cusc-rnr-portal-1.0.jar
	    ;;
	    
        4)
	    echo "You are chose update: cusc-rnr-h5-1.0.jar"
            update_jar cusc-rnr-h5-1.0.jar
	    ;;
	    
        5)
	    echo "You are chose update: cusc-rnr-notifier-1.0.jar"
            update_jar cusc-rnr-notifier-1.0.jar
	    ;;
	    
        6)
	    echo "You are chose update: cusc-rnr-admin-1.0.jar"
            update_jar cusc-rnr-admin-1.0.jar
	    ;;
	    
        7)
	    echo "You are chose update: cusc-rnr-task-1.0.jar"
            update_jar cusc-rnr-task-1.0.jar
	    ;;
	    
        8)
	    echo "You are chose update: cusc-rnr-report-1.0.jar"
            update_jar cusc-rnr-report-1.0.jar
	    ;;
	    
        9)
	    echo "You are chose update: update all *.jar "
            scp -P 60068 root@172.24.103.58:/opt/apps/autobuild/rnr/*.jar /opt/apps/
	    cd /opt/apps/
	    sh stop.sh
	    sh start.sh 1
	    ;;
	    
        0)
	    echo "You are chose:0 exit program"
            break
	    ;;	
	    
        *)
	    echo -e "\033[41;36m You are chose wrong num,please input again \033[0m"
	    echo -e "\033[41;36m You can only input int number [0-9] \033[0m"

    esac
	    
done
  
