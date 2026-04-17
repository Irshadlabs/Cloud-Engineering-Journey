# -----------------------------------------------------------------------------------
# Script: s3_compliance_audit.py
# Description: Automated security audit for S3 buckets to identify public access 
#              and missing server-side encryption.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

import boto3
from botocore.exceptions import ClientError

def audit_s3_compliance():
    s3 = boto3.client('s3')
    buckets = s3.list_buckets()
    
    print(f"{'Bucket Name':<40} | {'Public':<10} | {'Encryption':<10}")
    print("-" * 65)

    for bucket in buckets['Buckets']:
        name = bucket['Name']
        
        # 1. Check Public Access Block
        try:
            public_access = s3.get_public_access_block(Bucket=name)
            is_public = "Secure" if public_access['PublicAccessBlockConfiguration']['BlockPublicAcls'] else "WARNING"
        except ClientError:
            is_public = "UNKNOWN"

        # 2. Check Encryption
        try:
            encryption = s3.get_bucket_encryption(Bucket=name)
            has_encryption = "Enabled"
        except ClientError:
            has_encryption = "MISSING"

        print(f"{name:<40} | {is_public:<10} | {has_encryption:<10}")

if __name__ == "__main__":
    print("--- Starting AWS S3 Compliance Audit ---")
    audit_s3_compliance()
