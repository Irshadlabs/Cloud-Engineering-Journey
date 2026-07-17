#!/bin/bash
# AWS IAM Multi-Factor Authentication (MFA) Compliance Audit Tool
# Author: Irshadlabs (2026)

echo "=================================================="
echo "      🔐 STARTING AWS IAM MFA SECURITY AUDIT      "
echo "=================================================="

# Fetch all IAM users in the AWS account
echo "[*] Fetching IAM user list from AWS..."
USERS=$(aws iam list-users --query 'Users[*].UserName' --output text 2>&1)

if [[ "$USERS" == *"AccessDenied"* ]]; then
    echo "❌ CRITICAL: Access Denied. Your IAM role lacks 'iam:ListUsers' permission."
    exit 1
elif [ -z "$USERS" ]; then
    echo "💡 NOTICE: No IAM users found in this account (Root account usage only)."
    exit 0
fi

echo "--------------------------------------------------"
echo "User MFA Compliance Status:"
echo "--------------------------------------------------"

# Loop through each user and check MFA status
for USER in $USERS; do
    MFA_STATUS=$(aws iam list-mfa-devices --user-name "$USER" --query 'MFADevices[*].SerialNumber' --output text)
    
    if [ -z "$MFA_STATUS" ]; then
        echo "⚠️  VIOLATION : User '$USER' has NO MFA enabled."
    else
        echo "✅ COMPLIANT : User '$USER' is secured with MFA."
    fi
done

echo "=================================================="
echo "🎯 AUDIT COMPLETE: Zero-Cost Security Scan Done."
echo "=================================================="
