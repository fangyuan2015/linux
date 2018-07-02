#!/bin/bash
#date: 20170325

PATH=/server/scripts
MAIL_GROUP="546219618@qq.com"
PAGER_GROUP="111111 22222"
LOG_FILE="/tmp/web_check.log"

[ ! -d "$PATH" ] && mkdir -p $PATH

UrlList(){
    cat >$PATH/domain.list<<eof
    http://www.baidu.com
    http://www.sinna.com
eof
}

CheckUrl(){
    FAILCOUNT=0
    for ((i=1;$i<=3;i++))
    do
	wget -T 5 --tries=1 --spider $1 >/dev/null 2>&1
    	if [ $? -ne 0 ];then
	    let FAILCOUNT+=1;
	else
	    break
	fi	
    done
    return $FALLCOUNT
}

Mail(){
    local SUBJECT_CONTENT=$1
    for MAIL_USER in `echo $MAIL_GROUP`
    do
	mail -s "$SUBJECT_CONTENT " $MAIL_USER <$LOG_FILE
    done
}

Pager(){
    for PAGER_USER in `echo $PAGER_GROUP`
    do
    	TITLE=$1
	CONTACT=$PAGER_USER
	HTTPGW=sms.cn
	curl -d cdkey=adf -d password=fang -d phone=$CONTACT -d message=$"TITLE[$2]" $HTTPGW
    done
}

SendMsg(){
    if [ $1 -ge 3 ];then
	RETVAL=1
	NOW_TIME=`date +"%Y-%m-%d %H:%M:%S"`
	SUBJECT_CONTENT="http://$2 is error,${NOW_TIME}"
	echo -e "$SUBJECT_CONTENT"|tee $LOG_FILE
	MAIL $SUBJECT_CONTENT
	PAGER $SUBJECT_CONTENT $NOW_TIME
    else
	echo "http://$2 is ok"
	RETVAL=0
    fi
    return $RETVAL
}

main(){
    UrlList
    for url in `cat $path/domain.list`
    do
	CheckUrl $url
	SendMsg $? $url
    done
}
main
