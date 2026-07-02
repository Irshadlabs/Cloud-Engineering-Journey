#!/bin/bash
# Enterprise Docker Container Engine Runtime & Triage Tool
# Author: Irshadlabs (2026)

echo "=================================================="
echo "      🐳 STARTING DOCKER RUNTIME DIAGNOSTIC        "
echo "=================================================="

# 1. Verify Docker Daemon Operational Status
echo -n "[1/3] Checking Docker Daemon Connectivity... "
if systemctl is-active --quiet docker || docker info > /dev/null 2>&1; then
    echo "✅ ONLINE"
else
    echo "❌ CRITICAL: Docker Daemon is unresponsive or down!"
    echo "Remediation: Run 'sudo systemctl start docker' to recover the engine."
    exit 1
fi

# 2. Audit Container Resource Allocations & Active Counts
echo "--------------------------------------------------"
echo "[2/3] Analyzing Active Container Metrics:"
echo "--------------------------------------------------"
RUNNING_COUNT=$(docker ps -q | wc -l)
echo "Active Running Containers: $RUNNING_COUNT"

if [ "$RUNNING_COUNT" -gt 0 ]; then
    echo ""
    echo "Top Resource Consuming Containers (CPU/MEM):"
    docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}"
else
    echo "💡 Notice: No active running containers detected on host instance."
fi

# 3. Storage Leak Optimization Audit
echo "--------------------------------------------------"
echo "[3/3] Auditing Epheremal Storage & Dangling Layers:"
echo "--------------------------------------------------"
DANGLING_IMAGES=$(docker images -f "dangling=true" -q | wc -l)
ORPHAN_VOLUMES=$(docker volume ls -f "dangling=true" -q | wc -l)

echo "Dangling (Untagged) Image Layers Found: $DANGLING_IMAGES"
echo "Orphaned (Unattached) Storage Volumes Found: $ORPHAN_VOLUMES"

if [ "$DANGLING_IMAGES" -gt 0 ] || [ "$ORPHAN_VOLUMES" -gt 0 ]; then
    echo ""
    echo "⚠️  RECOMMENDATION: Run 'docker system prune -f' to reclaim system storage space."
else
    echo "✅ COMPLIANT: Local container host storage layout is optimized."
fi

echo "=================================================="
echo "🎯 AUDIT COMPLETE: Local Virtualization Safe."
echo "=================================================="
