#!/bin/bash
#date: 20170325

. /etc/init.d/functions
user="aa"
passfile="/tmp/user.log"
for num in `seq -w 11 13`
do
    PASS="`echo "test$RANDOM"|md5sum|cut -c3-11`"
    useradd $user$num &>/dev/null && \
    echo "$PASS"|passwd --stdin $user$num &>/dev/null && \
    echo -e "user:$user$num\tpassword:$PASS">>$passfile
    if [ $? -eq 0 ];then
        action "$user$num is ok" /bin/true
    else
 	action "$user$num is faile" /bin/false
    fi
done
echo --------------------
cat $passfile && >$passfile
