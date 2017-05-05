#!/bin/bash
#date:20170315

RED_COLOR='\E[1;31m'
GREEN_COLOR='\E[1;32m'
YELLOW_COLOR='\E[1;33m'
BLUE_COLOR='\E[1;34m'
RES='\E[0m'

function usage() {
    echo "USAGE: $0 {0|1|2|3|4}"
    exit 1
}
function menu() {
    cat <<eof
    1.apple
    2.pear
    3.banana
eof
}

function chose() {
    read -p "Please input you num: " ans
    case $ans in
	1)
	    echo -e "you choice is red ${RED_COLOR}apple${RES}"
	    ;;
	2)
	    echo -e "you choice is green ${GREEN_COLOR}pear${RES}"
	    ;;
	3)
	    echo -e "you choice is yellow ${YELLOW_COLOR}banana${RES}"
	    ;;
	*)
	    usage
    esac
}

function main() {
    menu
    chose
}
main
