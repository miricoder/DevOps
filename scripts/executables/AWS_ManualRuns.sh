#!/bin/bash
LOCALPATH="$(dirname "${BASH_SOURCE[0]}")"
source "$HOME"/Desktop/AWS/scripts/env.sh


#################################################################
#https://docs.aws.amazon.com/cli/latest/reference/ec2/stop-instances.html
#################################################################
instance_id=i-0619b57b294d5065a


InstanceType=$(aws ec2 describe-instances | jq ".Reservations[] | (.Instances[]) | {InstanceType}")
LaunchTime=$(aws ec2 describe-instances | jq ".Reservations[] | (.Instances[]) | {LaunchTime}")
InstanceId=$(aws ec2 describe-instances | jq ".Reservations[] | (.Instances[]) | {InstanceId}")

$LOG "DEBUG -- InstanceId: $InstanceId InstanceType: $InstanceType LaunchTime: $LaunchTime (State: )"
# State=$(aws ec2 describe-instances | jq ".Reservations[] | (.Instances[]) | {InstanceId})")	


# aws ec2 stop-instances --instance-ids i-1234567890abcdef0
# aws ec2 start-instances --instance-ids i-1234567890abcdef0



