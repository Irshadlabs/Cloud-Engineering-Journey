# =========================================================
# Project: AWS Cloud FinOps - EBS Cost Auditor
# Author: Mohammed Irshad 
# Description: Identifies unattached EBS volumes that are 
#              wasting money in the AWS account.
# =========================================================

import boto3

def audit_ebs_costs():
    ec2 = boto3.client('ec2')
    volumes = ec2.describe_volumes()
    
    unused_count = 0
    total_waste = 0

    print("--- AWS EBS Cost Analysis Report ---")
    
    for volume in volumes['Volumes']:
        # If the volume state is 'available', it means it's NOT attached to any EC2
        if volume['State'] == 'available':
            vol_id = volume['VolumeId']
            size = volume['Size']
            unused_count += 1
            total_waste += size
            print(f"[WASTE] Volume ID: {vol_id} | Size: {size}GB is NOT attached!")

    print("------------------------------------")
    print(f"Total Unused Volumes: {unused_count}")
    print(f"Total Wasted Storage: {total_waste} GB")
    
    if unused_count == 0:
        print("Congrats! Your account is cost-optimized. ✅")

if __name__ == "__main__":
    audit_ebs_costs()
