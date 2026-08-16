# -----------------------------------------------------------------------------------
# Script: iam_key_auditor.py
# Description: Identifies IAM Access Keys older than 90 days to prevent 
#              unauthorized access and comply with security best practices.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

import boto3
from datetime import datetime, timezone

def audit_iam_keys():
    iam = boto3.client('iam')
    users = iam.list_users()
    today = datetime.now(timezone.utc)
    
    print(f"{'User Name':<20} | {'Access Key ID':<25} | {'Age (Days)':<10} | {'Status'}")
    print("-" * 75)

    for user in users['Users']:
        user_name = user['UserName']
        keys = iam.list_access_keys(UserName=user_name)
        
        for key in keys['AccessKeyMetadata']:
            key_id = key['AccessKeyId']
            create_date = key['CreateDate']
            age = (today - create_date).days
            
            # Identify keys older than 90 days
            status = "WARNING (OLD)" if age > 90 else "HEALTHY"
            
            print(f"{user_name:<20} | {key_id:<25} | {age:<10} | {status}")

if __name__ == "__main__":
    print("--- Starting IAM Access Key Security Audit ---")
    audit_iam_keys()
