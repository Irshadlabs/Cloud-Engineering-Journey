#!/bin/bash
# -----------------------------------------------------------------------------------
# Script: network_health_check.sh
# Description: Monitors network latency and reachability for AWS endpoints.
# Author: Mohammed Irshad (CCNA & AWS Certified)
# -----------------------------------------------------------------------------------

# List of  AWS Endpoints (Replace with  actual ALB DNS or EC2 IPs)
TARGETS=("google.com" "10.0.0.1" "your-alb-dns-name.aws.com")

echo "Starting Network Health Audit at $(date)"
echo "------------------------------------------------"

for target in "${TARGETS[@]}"; do
    echo -n "Checking connectivity to $target... "
    
    # Using 'ping' with 3 packets and a 2-second timeout
    if ping -c 3 -W 2 "$target" > /dev/null; then
        # Calculating average latency using 'ping' and 'awk'
        latency=$(ping -c 3 "$target" | tail -1 | awk -F '/' '{print $5}')
        echo " [UP] - Latency: ${latency}ms"
    else
        echo " [DOWN] - Connection Failed!"
    fi
done

echo "------------------------------------------------"
echo "Network Audit Complete."
