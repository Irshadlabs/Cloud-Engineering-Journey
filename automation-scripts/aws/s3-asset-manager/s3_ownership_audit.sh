#!/bin/bash
# AWS S3 Bucket Object Ownership & Access Control Compliance Audit Tool
# Author: Irshadlabs (2026)

BUCKET_NAME="irshadlabs-mumbai-bucket-2026"

echo "=================================================="
echo "      📦 STARTING S3 OBJECT OWNERSHIP AUDIT       "
echo "=================================================="
echo "[*] TARGET BUCKET: $BUCKET_NAME"
echo "--------------------------------------------------"

# Fetch ownership controls from AWS API safely
OWNERSHIP_STATUS=$(aws s3api get-bucket-ownership-controls --bucket "$BUCKET_NAME" 2>&1)

if [ $? -eq 0 ]; then
    echo "✅ COMPLIANT: Object Ownership Controls are configured."
    echo "Details:"
    echo "$OWNERSHIP_STATUS" | grep -E "ObjectOwnership"
else
    # Handle case where no ownership rules are explicitly set (defaults apply)
    if [[ "$OWNERSHIP_STATUS" == *"OwnershipControlsNotFoundError"* ]]; then
        echo "⚠️  AUDIT NOTICE: No explicit Object Ownership configuration found (Using AWS Defaults)."
        echo "Recommendation: Enforce 'BucketOwnerEnforced' to disable legacy ACLs permanently."
    else
        echo "❌ ERROR: Failed to fetch ownership configuration."
        echo "Details: $OWNERSHIP_STATUS"
    fi
fi

echo "=================================================="
echo "🎯 AUDIT COMPLET."
echo "=================================================="
