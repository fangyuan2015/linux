#!/bin/bash
RETVAR=0
PATH=/server/scripts
[ ! -d "$PATH" ] && mkdir $PATH -p

Usage(){
    echo "Usage:$0 argv"
    return 1
}
InstallService(){
    if [ $# -ne 1 ];then
	Usage
    fi
    local RETVAR=0
    echo "start installing ${1}"
    /usr/bin/sleep 2;
    if [ ! -x "$PATH/${1}.sh" ];then
    	echo "$PATH/${1}.sh does not exist or can not be exec."
	return 1
    else
	$PATH/${1}.sh
	return $RETVAL
    fi
}

main(){
    PS3="`echo pls input the num you want:`"
    select var in "Install lamp" "Install lnmp" "exit"
    do
	case "$REPLY" in
	    1)
		InstallService lamp
		RETVAR=$?
		;;
	    2)
		InstallService lnmp
		RETVAL=$?
		;;
	    3)
		echo bye.
		return 3
		;;
	    *)
		echo "the num you input must be {1|2|3}"
		echo "Input error"
	esac
    done
exit $RETVAR
}

main
