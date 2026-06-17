#!/bin/bash

# =========================================================
# Project: AWS EC2 Instance Auditor
# Author: Mohammed Irshad
# Description: This script lists all EC2 instances, their 
#              States (Running/Stopped), and Public IPs.
# =========================================================

echo "--- AWS EC2 Resource Audit Started ---"
echo "Timestamp: $(date)"

# Use AWS CLI to fetch Instance ID, State, and Public IP
# We use --query for clean output and --output table for professional look
echo "Fetching EC2 Instance Details..."
echo "---------------------------------------------------------------------"

aws ec2 describe-instances --query 'Reservations[*].Instances[*].{ID:InstanceId,Type:InstanceType,State:State.Name,PublicIP:PublicIpAddress}' --output table

echo "---------------------------------------------------------------------"
echo "--- EC2 Audit Completed ---"
