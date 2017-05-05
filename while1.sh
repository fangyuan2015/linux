#!/bin/bash
total=0
export LANG="zh_CN.UTF-8"
NUM=$((RANDOM%61))

echo "当前苹果的价格是每斤${NUM}元"
echo "========================"
usleep 1000000
clear
echo "这苹果多少钱一斤啊？请猜0-60之间的数字"

apple() {
    read -p "请输入你的价格： " PRICE
    expr ${PRICE} + 1 &>/dev/null
    if [ $? -ne 0 ];then
	echo "别逗了，快猜整数"
	apple
    fi
}

guess() {
    ((total++))
    if [ $PRICE -eq $NUM ];then
	echo "猜对了，就是${NUM}元"
	if [ $total -le 3 ];then
	    echo "一共猜了${total}次，太牛了"
	elif [ ${total} -gt 3 -a ${total} -le 6 ];then
	    echo "一共猜了${total}次，加油哦，下次"
	elif [ ${total} -gt 6 ];then
	    echo "猜的次数是${total}"
	fi
  	exit 0
    elif [ ${PRICE} -gt ${NUM} ];then
 	echo "你猜的有点高哦，要不要买了"
	apple
    elif [ $PRICE -lt $NUM ];then
	echo "太低太低"
	echo "再给次机会，请继续猜"
	apple
    fi
}

main() {
    apple
    while true
    do
	guess
    done
}

main
