# -----------------------------------------------------------------------------------
# Script: tagging_auditor.py
# Description: Audits all EC2 instances to ensure they comply with organizational 
#              tagging policies (e.g., 'Environment' and 'Owner' tags).
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

import boto3

def audit_instance_tags():
    ec2 = boto3.client('ec2')
    instances = ec2.describe_instances()
    
    required_tags = ['Environment', 'Owner']
    
    print(f"{'Instance ID':<20} | {'Status':<15} | {'Missing Tags'}")
    print("-" * 60)

    for reservation in instances['Reservations']:
        for instance in reservation['Instances']:
            instance_id = instance['InstanceId']
            state = instance['State']['Name']
            
            # Get existing tags
            tags = {tag['Key']: tag['Value'] for tag in instance.get('Tags', [])}
            
            # Identify missing tags
            missing = [t for t in required_tags if t not in tags]
            
            if missing:
                print(f"{instance_id:<20} | {state:<15} | {', '.join(missing)}")
            else:
                print(f"{instance_id:<20} | {state:<15} | None (Compliant ✅)")

if __name__ == "__main__":
    print("--- Starting AWS Resource Tagging Audit ---")
    audit_instance_tags()
