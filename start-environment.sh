#!/bin/bash
#
# Requires 2 input parameters
# 1. The profile name that should be used (aws configure --profile)
# 2. The region you wish to search
#
# Example ./start-environment.sh dev-profile us-east-1

aws_profile=$1
region=$2
instances=`aws ec2 describe-instances --region $region --profile $aws_profile --query "Reservations[*].Instances[*].InstanceId" --filter "Name=instance-state-name,Values=stopping,stopped" --output text`

echo "Starting instances in $region"
aws ec2 start-instances --instance-ids $instances --region $region --profile $aws_profile --query "StartingInstances[*].CurrentState[*].Name" --output text
