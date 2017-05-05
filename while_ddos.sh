#!/bin/bash

file=$1
if [ ! -f $1 ];then
    echo "Usage:sh $0 filename"
    exit 0
fi

if [ ! -s $1 ];then
    echo "the filename is wrong"
    exit 0
fi
while true
do
    awk '{print $1}' $1|grep -v "^$"|sort|uniq -c >/tmp/tmp.log
    exec </tmp/tmp.log
    while read line
    do
	ip=`echo $line|awk '{print $2}'`
	count=`echo $line|awk '{print $1}'`
	if [ $count -gt 500 ] && [ `iptables -L -n|grep "$ip"|wc -l` -lt 1 ];then
	    iptables -I INPUT -s $ip -j DROP
	    echo "$line is dropped" >>/tmp/droplist_$(date +%F).log
	fi
    done
    sleep 3600
done
