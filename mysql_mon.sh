#!/bin/bash

if [ `netstat -tlnp|grep -v grep|grep 3306|wc -l` -gt 1 ];then
    echo "Mysql is running"
else
    echo "Mysql is not running"
fi
