#!/bin/bash
# AWS S3 Bucket Versioning Status Compliance Audit Tool
# Author: Irshadlabs (2026)

BUCKET_NAME="irshadlabs-mumbai-bucket-2026"

echo "=================================================="
echo "      📦 STARTING S3 VERSIONING STATUS AUDIT      "
echo "=================================================="
echo "[*] TARGET BUCKET: $BUCKET_NAME"
echo "--------------------------------------------------"

# Fetch versioning status from AWS API safely
VERSIONING_STATUS=$(aws s3api get-bucket-versioning --bucket "$BUCKET_NAME" 2>&1)

if [ $? -eq 0 ]; then
    if [ -z "$VERSIONING_STATUS" ]; then
        echo "⚠️  AUDIT NOTICE: Versioning is currently DISABLED/SUSPENDED on this bucket."
        echo "Recommendation: Enable bucket versioning in production to protect against accidental deletion."
    else
        echo "✅ COMPLIANT: Bucket Versioning is ENABLED."
        echo "Details:"
        echo "$VERSIONING_STATUS"
    fi
else
    echo "❌ ERROR: Failed to fetch versioning configuration."
    echo "Details: $VERSIONING_STATUS"
fi

echo "=================================================="
echo "🎯 AUDIT COMPLET."
echo "=================================================="
