#!/bin/bash
# -----------------------------------------------------------------------------------
# Script: docker_health_audit.sh
# Description: Automated health and security check for running Docker containers.
#              Identifies high resource usage and insecure root execution.
# Author: Mohammed Irshad (AWS Solutions )
# -----------------------------------------------------------------------------------

echo "--- Starting Docker Health & Security Audit ---"
echo "Timestamp: $(date)"
echo "------------------------------------------------"

# 1. Check for containers running as Root (Security Risk)
echo "[1] Security Check: Checking for Root execution..."
docker ps -q | xargs docker inspect --format '{{.Name}}: User={{.Config.User}}' | while read output; do
    if [[ $output == *"User="* && $output != *"User= "* ]]; then
        echo " [SAFE] $output"
    else
        echo " [WARNING] $output (Running as Root!)"
    fi
done

# 2. Check Resource Utilization (Top 3 CPU consumers)
echo -e "\n[2] Resource Check: Top 3 CPU Consuming Containers..."
docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}" | sort -k 2 -hr | head -n 4

# 3. Check for Unhealthy Containers
echo -e "\n[3] Health Check: Identifying Unhealthy containers..."
unhealthy_containers=$(docker ps -a --filter "health=unhealthy" -q)

if [ -z "$unhealthy_containers" ]; then
    echo " [OK] All containers are healthy."
else
    echo " [ALERT] Found Unhealthy containers: $unhealthy_containers"
fi

echo -e "\n------------------------------------------------"
echo "Audit Complete."
