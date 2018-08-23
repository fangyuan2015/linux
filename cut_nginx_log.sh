#!/bin/bash
cd /usr/local/nginx/logs
/bin/mv access.log www_access_$(date +%F -d '-1day').log
/usr/local/nginx/sbin/nginx -s reload
