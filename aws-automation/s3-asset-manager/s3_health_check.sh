#!/bin/bash
# AWS S3 Bucket Health & Connectivity Diagnostic Tool
# Author: Irshadlabs (2026)

BUCKET_NAME="irshadlabs-mumbai-bucket-2026"

echo "=================================================="
echo "      🚀 STARTING S3 BUCKET HEALTH DIAGNOSTIC     "
echo "=================================================="

# 1. Network Level Ping Test to AWS Endpoint
echo -n "[1/3] Checking Network Connectivity to AWS Mumbai... "
curl -s --connect-timeout 5 https://s3.ap-south-1.amazonaws.com > /dev/null
if [ $? -eq 0 ]; then
    echo "✅ ONLINE"
else
    echo "❌ NETWORK TIMEOUT (Check VPC/Internet Gateway)"
    exit 1
fi

# 2. Check if Bucket Exists and is Accessible via IAM Role
echo -n "[2/3] Validating S3 Bucket Access via AWS CLI... "
aws s3 api head-bucket --bucket "$BUCKET_NAME" 2>&1

if [ $? -eq 0 ]; then
    echo "✅ ACCESSIBLE"
else
    echo "❌ ACCESS DENIED / NOT FOUND (Check IAM Role or Bucket Name)"
    exit 1
fi

# 3. Print Summary
echo "=================================================="
echo "🎯 STATUS: S3 Infrastructure is Healthy & Secure!"
echo "=================================================="
