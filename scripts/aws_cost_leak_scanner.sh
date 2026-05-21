#!/bin/bash
# -----------------------------------------------------------------------------------
# Script Name: aws_cost_leak_scanner.sh
# Description: Scans AWS regions for unused, unattached, and orphaned resources
#              that are causing unnecessary financial leaks.
# Author: Mohammed Irshad (Cloud & DevOps Specialist)
# -----------------------------------------------------------------------------------

echo "===================================================="
echo "      🔍 STARTING AWS COST LEAK SCANNER             "
echo "===================================================="

# 1. Check for Unattached Elastic IPs
echo -e "\n[1] Checking for Unused Elastic IPs..."
UNUSED_EIPS=$(aws ec2 describe-addresses --query "Addresses[?AssociationId==null].PublicIp" --output text)

if [ -z "$UNUSED_EIPS" ]; then
    echo "✅ No unused Elastic IPs found."
else
    echo "⚠️ WARNING: Following Elastic IPs are unattached and costing money:"
    echo "$UNUSED_EIPS"
fi

# 2. Check for Unattached EBS Volumes
echo -e "\n[2] Checking for Unattached EBS Volumes..."
UNUSED_VOLUMES=$(aws ec2 describe-volumes --query "Volumes[?State=='available'].VolumeId" --output text)

if [ -z "$UNUSED_VOLUMES" ]; then
    echo "✅ No orphaned EBS volumes found."
else
    echo "⚠️ WARNING: Following EBS volumes are detached and consuming budget:"
    echo "$UNUSED_VOLUMES"
fi

# 3. Check for Stopped EC2 Instances (Still costing for root storage)
echo -e "\n[3] Checking for Stopped EC2 Instances..."
STOPPED_INSTANCES=$(aws ec2 describe-instances --filters "Name=instance-state-name,Values=stopped" --query "Reservations[*].Instances[*].InstanceId" --output text)

if [ -z "$STOPPED_INSTANCES" ]; then
    echo "✅ No stopped EC2 instances found."
else
    echo "ℹ️ INFO: Following instances are stopped but occupying disk space:"
    echo "$STOPPED_INSTANCES"
fi

echo -e "\n===================================================="
echo "      🎯 SCAN COMPLETED SUCCESSFULLY                "
echo "===================================================="
