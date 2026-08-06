#!/bin/bash
# AWS EC2 Security Group Compliance & Open Port Auditor
# Author: Irshadlabs (2026)

echo "=================================================="
echo "   🛡️  STARTING AWS EC2 SECURITY GROUP AUDIT      "
echo "=================================================="

# Check EC2 Describe Security Groups permissions
CHECK_PERM=$(aws ec2 describe-security-groups --max-items 1 2>&1)

if [[ "$CHECK_PERM" == *"AccessDenied"* ]]; then
    echo "❌ CRITICAL: Access Denied. Role needs 'ec2:DescribeSecurityGroups' permission."
    exit 1
fi

echo "[*] Scanning for Security Groups with unrestricted public ingress (0.0.0.0/0)..."
echo "--------------------------------------------------"

# Fetch Security Groups that have 0.0.0.0/0 CIDR in ingress rules
UNRESTRICTED_SGS=$(aws ec2 describe-security-groups \
  --filters Name=ip-permission.cidr,Values='0.0.0.0/0' \
  --query 'SecurityGroups[*].[GroupId,GroupName]' \
  --output text)

if [ -z "$UNRESTRICTED_SGS" ]; then
    echo "✅ COMPLIANT: No Security Groups found allowing unrestricted 0.0.0.0/0 traffic."
else
    echo "⚠️  WARNING: The following Security Groups allow PUBLIC ACCESS (0.0.0.0/0):"
    echo "--------------------------------------------------"
    echo "$UNRESTRICTED_SGS" | while read -r SG_ID SG_NAME; do
        echo "🚨 Group ID: $SG_ID  |  Group Name: $SG_NAME"
    done
fi

echo "=================================================="
echo "🎯 AUDIT COMPLETE: Zero-Cost Security Group Scan Done."
echo "=================================================="
