#!/bin/bash
# AWS IAM Access Key Age & Security Audit Tool
# Author: Irshadlabs (2026)

echo "=================================================="
echo "   🔑 STARTING AWS IAM ACCESS KEY SECURITY AUDIT   "
echo "=================================================="

CURRENT_SEC=$(date +%s)
EXPIRATION_DAYS=90
SEC_IN_DAY=86400

# Fetch all IAM users
USERS=$(aws iam list-users --query 'Users[*].UserName' --output text 2>&1)

if [[ "$USERS" == *"AccessDenied"* ]]; then
    echo "❌ CRITICAL: Access Denied. Role needs 'iam:ListAccessKeys' permissions."
    exit 1
elif [ -z "$USERS" ]; then
    echo "💡 NOTICE: No IAM users found in this account."
    exit 0
fi

echo "--------------------------------------------------"
echo "Access Key Age Audit Status (Threshold: ${EXPIRATION_DAYS} Days):"
echo "--------------------------------------------------"

for USER in $USERS; do
    # Retrieve Access Key Metadata
    KEYS=$(aws iam list-access-keys --user-name "$USER" --query 'AccessKeyMetadata[*].[AccessKeyId,CreateDate,Status]' --output text)

    if [ -z "$KEYS" ]; then
        echo "ℹ️  INFO: User '$USER' has no Access Keys."
        continue
    fi

    echo "$KEYS" | while read -r KEY_ID CREATE_DATE STATUS; do
        # Format creation date to seconds for age calculation (cross-platform compatible)
        # Standardize ISO date format
        CLEAN_DATE=$(echo "$CREATE_DATE" | cut -d'T' -f1)
        
        # Linux date conversion to epoch seconds
        KEY_SEC=$(date -d "$CLEAN_DATE" +%s 2>/dev/null || date -j -f "%Y-%m-%d" "$CLEAN_DATE" +%s)
        
        AGE_DAYS=$(( (CURRENT_SEC - KEY_SEC) / SEC_IN_DAY ))

        if [ "$AGE_DAYS" -gt "$EXPIRATION_DAYS" ]; then
            echo "⚠️  WARNING : User '$USER' | Key ID: $KEY_ID | Age: $AGE_DAYS days | Status: $STATUS [EXCEEDS 90-DAY POLICY]"
        else
            echo "✅ COMPLIANT: User '$USER' | Key ID: $KEY_ID | Age: $AGE_DAYS days | Status: $STATUS"
        fi
    done
done

echo "=================================================="
echo "🎯 AUDIT COMPLETE: Zero-Cost Access Key Audit Finished."
echo "=================================================="
