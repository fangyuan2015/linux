#!/bin/bash
printf "del key\r\n"|nc 127.0.0.1 11211 &>/dev/null
printf "set key 0 0 10 \r\noldboy1234\r\n"|nc 127.0.0.1 11211 &>/dev/null
MCVALUES=`printf "get key\r\n"|nc 127.0.0.1 11211|grep oldboy1234|wc -l`
if [ $MCVALUES -eq 1 ];then
    echo "memcached status is ok"
else
    echo "memcached status is wrong"
fi
