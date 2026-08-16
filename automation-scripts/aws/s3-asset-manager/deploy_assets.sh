#!/bin/bash

# Safe Configuration (Free Tier Rules Inside)
BUCKET_NAME="irshadlabs-mumbai-bucket-2026"

echo "Checking AWS connectivity and syncing assets..."

# AWS S3 Sync: Yeh sirf nayi/changed files bhejta hai (Requests bachaega, zero bill!)
aws s3 sync . s3://$BUCKET_NAME/assets/ --exclude "deploy_assets.sh"

if [ $? -eq 0 ]; then
    echo "SUCCESS: Assets deployed to AWS S3 safely!"
else
    echo "ERROR: Deployment failed. Check EC2 IAM Role permissions."
fi
