#!/bin/bash
#
# Requires 2 input parameters
# 1. The profile name that should be used (aws configure --profile)
# 2. The region you wish to search
#
# Example ./stop-environment.sh dev-profile us-east-1

aws_profile=$1
region=$2
instances=`aws ec2 describe-instances --region $region --profile $aws_profile --query "Reservations[*].Instances[*].InstanceId" --output text`

echo "Stopping instances in $region"
aws ec2 stop-instances --instance-ids $instances --region $region --profile $aws_profile
