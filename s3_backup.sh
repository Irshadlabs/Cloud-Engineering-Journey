#!/bin/bash

# Variables Definition
BUCKET_NAME="irshadlabs-mumbai-bucket-2026"
SOURCE_DIR="/home/mdirshad/Cloud-Engineering-Journey/logs"
TIMESTAMP=$(date +%Y-%m-%d-%H%M%S)

echo "========================================="
echo "Starting Backup to S3 at: $TIMESTAMP"
echo "========================================="

# AWS S3 Sync Command (Yeh sirf nayi ya badli hui files hi bhejta hai)
aws s3 sync $SOURCE_DIR s3://$BUCKET_NAME/server-logs/

if [ $? -eq 0 ]; then
    echo "SUCCESS: Logs successfully synced to S3 Bucket!"
else
    echo "ERROR: S3 Backup Failed! Check IAM Role or Network."
fi
echo "========================================="
