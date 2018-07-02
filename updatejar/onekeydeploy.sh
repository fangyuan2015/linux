#!/bin/bash
scp -P 60068 root@172.24.103.58:/opt/apps/autobuild/rnr/*.jar /opt/apps/

cd /opt/apps/
sh stop.sh
sh start.sh 1
