#!/bin/bash

# =========================================================
# Project: AWS S3 Resource Auditor
# Author: Mohammed Irshad
# Description: This script lists all S3 buckets and 
#              calculates their total size using AWS CLI.
# =========================================================

echo "--- AWS S3 Audit Started ---"
echo "Timestamp: $(date)"

# 1. List all S3 buckets in the account
echo "Fetching list of S3 buckets..."
BUCKETS=$(aws s3 ls | awk '{print $3}')

if [ -z "$BUCKETS" ]; then
    echo "[INFO] No S3 buckets found in this account."
else
    for BUCKET in $BUCKETS
    do
        echo "--------------------------------------"
        echo "Bucket Name: $BUCKET"
        
        # 2. Calculate the size of each bucket
        # 's3api' is used for more detailed information
        SIZE=$(aws s3api list-objects --bucket "$BUCKET" --output json --query "[sum(Contents[].Size), length(Contents[])]" | jq -r '.')
        
        echo "Details (Size in bytes, Total Objects): $SIZE"
    done
fi

echo "--------------------------------------"
echo "--- AWS Audit Completed ---"
