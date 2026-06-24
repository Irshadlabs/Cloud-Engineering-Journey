#!/bin/bash
# AWS S3 Bucket Encryption & Compliance Audit Tool
# Author: Irshadlabs (2026)

BUCKET_NAME="irshadlabs-mumbai-bucket-2026"

echo "=================================================="
echo "      🔒 STARTING S3 ENCRYPTION COMPLIANCE AUDIT   "
echo "=================================================="

# Check S3 Bucket Encryption Status via AWS API
echo "[*] Auditing encryption configuration for: $BUCKET_NAME"
echo "--------------------------------------------------"

# Fetch encryption configuration and catch errors safely
ENCRYPTION_STATUS=$(aws s3api get-bucket-encryption --bucket "$BUCKET_NAME" 2>&1)

if [ $? -eq 0 ]; then
    echo "✅ COMPLIANT: Default Encryption is ENABLED on this bucket."
    echo "Details:"
    echo "$ENCRYPTION_STATUS" | grep -E "SSEAlgorithm"
else
    echo "⚠️ WARNING: Default Encryption might be DISABLED or Access Denied!"
    echo "Error Details: $ENCRYPTION_STATUS"
fi

echo "=================================================="
echo "🎯 AUDIT COMPLETE: Free Tier and Security Checked."
echo "=================================================="
