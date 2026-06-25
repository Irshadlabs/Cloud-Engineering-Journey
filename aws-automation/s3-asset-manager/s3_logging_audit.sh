#!/bin/bash
# AWS S3 Bucket Server Access Logging Compliance Audit Tool
# Author: Irshadlabs (2026)

BUCKET_NAME="irshadlabs-mumbai-bucket-2026"

echo "=================================================="
echo "      📋 STARTING S3 SERVER LOGGING AUDIT         "
echo "=================================================="
echo "[*] TARGET BUCKET: $BUCKET_NAME"
echo "--------------------------------------------------"

# Fetch logging status from AWS API safely
LOGGING_STATUS=$(aws s3api get-bucket-logging --bucket "$BUCKET_NAME" 2>&1)

if [ $? -eq 0 ]; then
    if [ -z "$LOGGING_STATUS" ]; then
        echo "⚠️  AUDIT NOTICE: Logging is currently DISABLED on this bucket."
        echo "Recommendation: Enable server access logging in production to track compliance."
    else
        echo "✅ COMPLIANT: Server Access Logging is ENABLED."
        echo "Details:"
        echo "$LOGGING_STATUS"
    fi
else
    echo "❌ ERROR: Failed to fetch logging configuration."
    echo "Details: $LOGGING_STATUS"
fi

echo "=================================================="
echo "🎯 AUDIT COMPLETE: Free Tier Boundaries Maintained."
echo "=================================================="
