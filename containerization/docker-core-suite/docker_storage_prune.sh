#!/bin/bash
# Enterprise Docker Automated Local Storage Optimization & Pruning Engine
# Author: Irshadlabs (2026)

echo "=================================================="
echo "      🐳 INITIALIZING DOCKER STORAGE PRUNE        "
echo "=================================================="

# 1. Capture Pre-Prune Disk Footprint State
echo "[*] Calculating initial container engine storage footprints..."
INITIAL_USAGE=$(docker system df --format "{{.Size}}")
echo "Current allocated storage layouts:"
docker system df

echo "--------------------------------------------------"
echo "[*] Scanning host system directory parameters..."
DISK_UTILIZATION=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
echo "Host root filesystem usage is currently at: ${DISK_UTILIZATION}%"

# 2. Execution Condition Check (Safe Storage Threshold Evaluation)
# If storage usage is low, we only run a targeted clean instead of a full wipe
if [ "$DISK_UTILIZATION" -lt 85 ]; then
    echo "💡 NOTICE: System disk usage is below 85%. Performing low-impact targeted prune."
    echo "--------------------------------------------------"
    
    echo "[*] Dropping unattached dangling image layers..."
    docker image prune -f
    
    echo "[*] Purging stopped or abandoned container layers..."
    docker container prune -f
else
    echo "⚠️  WARNING: Host filesystem utilization exceeds threshold. Running deep system prune."
    echo "--------------------------------------------------"
    # Clear stopped containers, dangling images, and unused networks safely
    docker system prune -f
fi

# 3. Capture Post-Prune Delta Analysis
echo "--------------------------------------------------"
echo "✅ STORAGE OPTIMIZATION COMPLETED"
echo "--------------------------------------------------"
echo "Optimized storage layout metrics:"
docker system df

echo "=================================================="
