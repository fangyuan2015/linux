#!/bin/bash
#description:用于清理部署和备份的较早文件以及应用产生的文件

find /SSY/Backup/ -maxdepth 1 -type d -mtime +60|xargs rm -rf
#清理超过60天的应用备份目录

find /SSY/Deploy/ -maxdepth 1 -type d -mtime +30|xargs rm -rf
#清理超过30天的应用目录

if [ -d /SSY/project/ims/download ];then
    find /SSY/project/ims/download/ -maxdepth 1 -type d -mtime +30|xargs rm -rf
else
    echo "There is no /SSY/project/ims/download"
fi
#只针对有ims应用的系统进行清理

