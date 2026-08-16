#!/bin/bash

# =========================================================
# Project: AWS Security Group Rules Auditor
# Author: Mohammed Irshad
# Description: This script lists Security Groups and their 
#              Inbound rules (Ports & Protocols).
# Security Note: This script does NOT log sensitive Account IDs.
# =========================================================

echo "--- AWS NETWORK SECURITY AUDIT ---"
echo "Check started on: $(date)"
echo "------------------------------------------------------------"

# Fetching Security Group Name, Group ID, and Inbound Rules
# We use --query to only show GroupName and IpPermissions
echo "Listing Security Groups and Open Ports:"
aws ec2 describe-security-groups --query 'SecurityGroups[*].{Name:GroupName,Rules:IpPermissions[*].{FromPort:FromPort,ToPort:ToPort,Protocol:IpProtocol}}' --output table

echo "------------------------------------------------------------"
echo "Audit Finished. Review open ports for security compliance."
