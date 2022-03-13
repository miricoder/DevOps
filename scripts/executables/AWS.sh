#!/bin/bash 
#******TO DO 
############# --- 1) Put in GIT Repo - call this version bash_awsCli

LOCALPATH="$(dirname "${BASH_SROUCE[0]}")"
source "$HOME"/Desktop/DevOps/scripts/env.sh

rundir=`dirname $0`
csv=$rundir/aws_data.csv
instance_id=

usage(){
	echo "usage: "
	echo "How to use it....."
	echo "Describer Instances / Get the Instance Array - ./AWS.sh list "
	echo "Start Instances / A Specific Instance Id     - ./AWS.sh start <instance_id>"
	echo "Stop Instances / A Specific Instance Id     - ./AWS.sh stop <instance_id>"
	echo ""
	echo "Where____"
	echo " Instance ID is appended to commands starting with  ./AWS.sh start "
	echo " 								to start a specific instance id......."
	exit 1
}

findCommand() {
    egrep "$1" $csv | awk -F, '{ printf ("%s\t%s\n",$1,$2); }' | awk '{print $2}' 
    exit 0 
}

if [ $# -lt 1 ]; then 
	usage
	exit 2
fi	 

# parsedCmdLine() {
# #******TO DO 
# ############# --- 2) Add list, start , stop , instance_id related case options


# 	# while getopts ":sh-:" opt
# 	# do 
# 	# 	case "${opt}" in 
# 	# 		-)
# 	# 			val=${OPTARG#*=}
# 	# 			case $OPTARG in 
# 	# 				instance_id=*) instance_id="${val}";;
# 	# 			*)
# 	# 				echo invalid argument: "${OPTARG}"
# 	# 				exit 1
# 	# 				;;
# 	# 			esac 
# 	# 			;;	
# 	# 		h)
# 	# 			usage
# 	# 			exit 1
# 	# 			;;
# 	# 		*)
# 	# 			echo unrecognized argument: "${OPTARG}"	
# 	# 			exit 2
# 	# 			;;
# 	# 	esac
# 	# done 	
				

# }
# parsedCmdLine "$@"

# if [[ $commandFound == "describe-instances" ]]; then
if [ $findCommand "$1" == list ]; then
	commandFound=$([ $# -eq 1 ] && findCommand "$1")
	command_ran=$(aws ec2 $commandFound)
	echo "$command_ran" > TEST.json
	InstanceType=$(echo $command_ran | jq ".Reservations[] | (.Instances[]) | {InstanceType}")
	LaunchTime=$(echo $command_ran | jq ".Reservations[] | (.Instances[]) | {LaunchTime}")
	InstanceId=$(echo $command_ran | jq ".Reservations[] | (.Instances[]) | {InstanceId}")
	STATE_CODE=$(echo $command_ran | jq ".Reservations[] | (.Instances[]) | {State} | .State | {Code}")
	STATE_NAME=$(echo $command_ran | jq ".Reservations[] | (.Instances[]) | {State} | .State | {Name}")

	$LOG "DEBUG -- InstanceId: $InstanceId InstanceType: $InstanceType LaunchTime: $LaunchTime (State [ Code: $STATE_CODE Name: $STATE_NAME] )"

# elif [[ $commandFound == "start-instances" ]]; then
elif (( $findCommand "$1" == start || $findCommand "$1" == stop )); then
	instance_id=$2
	commandFound=$([ $# -eq 2 ] && findCommand "$1")
	command_ran=$(aws ec2 $commandFound --instance-ids $instance_id)	
	$LOG "PASSED --  $command_ran"
fi









