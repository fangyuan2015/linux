#!/bin/bash

PATH="/application/mysql/bin:$PATH"
MYUSER=root
MYPASS=oldboy123
SOCKET=/data/3306/mysql.sork
MYCMD="mysql -u$MYUSER -p$MYPASS -S $SOCKET"

for dbname in oldboy oldgirl xiaoting bingbing
do
    $MYCMD -e "create database $dbname"
done

