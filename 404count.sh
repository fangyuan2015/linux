#!/bin/bash
#date:2017/05/05
#Version:1.0
#Decription:count the 404 page
#QQ:546219618


PAGE_404=`cat /var/log/nginx/access.log |awk '{print $9}'|grep 404|wc -l`
PAGE_ALL=`cat /var/log/nginx/access.log |awk '{print $9}'|wc -l`
PAGE_404PER=$(echo "scale=3;${PAGE_404} / ${PAGE_ALL} * 100 "|bc -l)

echo "The  page of 404 percent is $PAGE_404PER%"
