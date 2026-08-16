# -----------------------------------------------------------------------------------
# Script: cost_explorer_report.py
# Description: Queries the AWS Cost Explorer API to retrieve and display daily 
#              spending trends for the last 7 days, broken down by service.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

import boto3
from datetime import datetime, timedelta

def get_cost_report():
    client = boto3.client('ce') # Cost Explorer Client
    
    # Define time period (Last 7 days)
    end = datetime.now().date()
    start = end - timedelta(days=7)
    
    response = client.get_cost_and_usage(
        TimePeriod={
            'Start': str(start),
            'End': str(end)
        },
        Granularity='DAILY',
        Metrics=['UnblendedCost'],
        GroupBy=[{'Type': 'DIMENSION', 'Key': 'SERVICE'}]
    )

    print(f"{'Date':<12} | {'Service':<30} | {'Cost ($)':<10}")
    print("-" * 55)

    for day in response['ResultsByTime']:
        date = day['TimePeriod']['Start']
        for group in day['Groups']:
            service = group['Keys'][0]
            amount = float(group['Metrics']['UnblendedCost']['Amount'])
            
            # Sirf un services ko dikhayein jin par kharcha hua hai (> $0.01)
            if amount > 0.01:
                print(f"{date:<12} | {service:<30} | {amount:<10.2f}")

if __name__ == "__main__":
    print("--- Starting AWS Cost Analytics Report ---")
    get_cost_report()
