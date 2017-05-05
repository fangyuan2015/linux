#!/bin/bash

for i in `docker ps -a|awk 'NR>=2 {print $1}'`;do docker rm $i;done

echo $?

