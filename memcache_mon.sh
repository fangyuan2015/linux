#!/bin/bash
printf "del key\r\n"|nc 127.0.0.1 11211 &>/dev/null
printf "set key 0 0 10 \r\noldboy1234\r\n"|nc 127.0.0.1 11211 &>/dev/null
MCVALUES=`printf "get key\r\n"|nc 127.0.0.1 11211|grep oldboy1234|wc -l`
if [ $MCVALUES -eq 1 ];then
    echo "memcached status is ok"
else
    echo "memcached status is wrong"
fi
CMD_GET=`printf "stats\r\n"|nc 127.0.0.1 11211|grep "cmd_get"|awk '{print $3}'|tr '\r' ' '`

GET_HITS=`printf "stats\r\n"|nc 127.0.0.1 11211|grep "get_hits"|awk '{print $3}'|tr '\r' ' '`
echo "get command request count is :$CMD_GET"
echo "hit get request count is $GET_HITS"
HIT_RATE=`echo "scale=2;$GET_HITS/$CMD_GET*100"|bc`
echo "The hit rate is ${HIT_RATE}%"
