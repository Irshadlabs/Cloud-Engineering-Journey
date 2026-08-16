# -----------------------------------------------------------------------------------
# Script: chaos_monkey.py
# Description: Randomly terminates EC2 instances tagged as 'Testing' to test 
#              infrastructure resilience and Auto Scaling recovery speed.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

import boto3
import random

def trigger_chaos():
    ec2 = boto3.client('ec2')
    
    # 1. Sirf 'Testing' environment ke instances dhundein (Safety First!)
    filters = [
        {'Name': 'tag:Environment', 'Values': ['Testing']},
        {'Name': 'instance-state-name', 'Values': ['running']}
    ]
    
    instances = ec2.describe_instances(Filters=filters)
    instance_list = []

    for reservation in instances['Reservations']:
        for instance in reservation['Instances']:
            instance_list.append(instance['InstanceId'])

    if not instance_list:
        print("No 'Testing' instances found running. Chaos Monkey is sleeping.")
        return

    # 2. Randomly ek instance pick karein terminate karne ke liye
    target = random.choice(instance_list)
    
    print(f"[CHAOS ALERT] Target acquired: {target}")
    print(f"[ACTION] Terminating instance to test Auto Scaling recovery...")
    
    ec2.terminate_instances(InstanceIds=[target])
    print(f"[SUCCESS] {target} has been terminated. Now watch your ASG heal the system!")

if __name__ == "__main__":
    print("--- Starting Chaos Engineering Drill ---")
    trigger_chaos()
