#!/bin/bash
#
# Requires 2 input parameters
# 1. The profile name that should be used (aws configure --profile)
# 2. The region you wish to search
#
# Example ./elb-instance-health.sh dev-profile us-east-1

region=$2
aws_profile=$1
loadbalancers=`aws elb describe-load-balancers --region $region --profile $aws_profile --query "LoadBalancerDescriptions[*].LoadBalancerName" --output text`

for loadbalancer in $loadbalancers
do
  echo "Finding healthy instances in $loadbalancer"
  aws elb describe-instance-health --load-balancer-name $loadbalancer --region $region --profile $aws_profile --query "InstanceStates[*].State" --output text
  echo ""
done

