#!/bin/bash

. /etc/init.d/functions
check_count=0
url_list=(
http://www.baidu.com
http://sina.com
http://sohu.com
)

wait(){
    echo -n "3秒后，执行检查URL操作.";
    for ((i=0;i<3;i++))
    do
	echo -n ".";sleep 1
    done
    echo
}

check_url(){
    wait
    for ((i=0;i<`echo ${#url_list[*]}`;i++))
    do
	wget -o /dev/null -T 3 --tries=1 --spider ${url_list[$i]} >/dev/null 2>&1
	if [ $? -eq 0 ];then
	    action "${url_list[$i]}" /bin/true
	else
	    action "${url_list[$i]}" /bin/false
	fi
    done
    ((check_count++))
}

main(){
    while true
    do
	check_url
	echo "----------check count:${check_count}----------------"
	sleep 10
    done
}
main
