import os
import subprocess
import datetime

# --- Project: Cloud Connectivity Auditor ---
# Author: Mohammed Irshad
# Description: This script checks network latency to Cloud Providers (AWS/Google)

def check_latency(host):
    print(f"Checking connectivity to {host}...")
    # Using 'ping' command with 3 packets
    response = os.system(f"ping -c 3 {host} > /dev/null 2>&1")
    
    if response == 0:
        print(f"[OK] {host} is reachable.")
    else:
        print(f"[FAILED] {host} is unreachable!")

def main():
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    print(f"--- Cloud Audit Started at {timestamp} ---")
    
    # List of cloud endpoints to check
    cloud_endpoints = ["8.8.8.8", "s3.amazonaws.com", "github.com"]
    
    for site in cloud_endpoints:
        check_latency(site)
    
    print("--- Audit Completed ---")

if __name__ == "__main__":
    main()
