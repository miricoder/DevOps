#!/bin/bash

LOCALPATH="$(dirname "${BASH_SOURCE[0]}")"
source "$HOME"/Desktop/AWS/scripts/env.sh

# first=$1  #If the first word is an IAN, then change to username and pring that
log=$@

# username=`$UTILPATH/getUsername.sh $first`

foundPASSED=`echo $log | grep PASSED`
foundFAILED=`echo $log | grep FAILED` 
foundNOTEST=`echo $log | grep "NO-TEST"` 
foundDEBUG=`echo $log | grep DEBUG`
useColor="1"
if [ "$foundPASSED" != "" ]; then
	COLOR=$GREEN 
elif [ "$foundFAILED" != "" ]; then
	COLOR=$RED
elif [ "$foundNOTEST" != "" ]; then
	COLOR=$ORANGE
elif [ "$foundDEBUG" != "" ]; then
	COLOR=$YELLOW
else 
	useColor="0"
fi

if [ "$username" != "" ]; then   #Replace IAN with username
    endlog=`echo $log | cut -d ' ' -f2-`
		if [ "$useColor" == "0" ]; then
			echo -e `date +"%m/%d/%Y--%H:%M:%S"`": [$username] $endlog"
		else
    	echo -e `date +"%m/%d/%Y--%H:%M:%S"`": ${COLOR}[$username] $endlog${NC}"  
		fi		
else
		if [ "$useColor" == "0" ]; then
			echo -e `date +"%m/%d/%Y--%H:%M:%S"`": $log"
		else
    	echo -e `date +"%m/%d/%Y--%H:%M:%S"`": ${COLOR}$log${NC}"
		fi

fi

