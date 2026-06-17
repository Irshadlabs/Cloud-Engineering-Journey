#!/bin/bash
# ========================================================================
# Script Name:  network_egress_auditor.sh
# Description:  Automated Outbound Firewall Network & Port State Auditor
# Author:       Mohammed Irshad (CCNA / Cloud Engineer)
# ========================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0;0m'

# Targets definitions for infrastructure sanity paths
TEST_TARGET="8.8.8.8"
# Critical compliance ports to scan for reverse connectivity or leak states
COMPLIANCE_PORTS=(22 80 443 445 3389)
TIMEOUT_LIMIT=2

echo "======================================================="
echo "🔒 STARTING ENTERPRISE EGRESS FIREWALL AUDIT ROUTINE"
echo "======================================================="

# --- PHASE 1: ICMP LAYER EDGE DIAGNOSTICS ---
echo -e "[Phase 1]: Testing Core Network Reachability (ICMP Layer)..."
if ping -c 1 -W $TIMEOUT_LIMIT $TEST_TARGET > /dev/null 2>&1; then
    echo -e "${YELLOW}[WARNING] Direct ICMP Outbound route is active to $TEST_TARGET.${NC}"
else
    echo -e "${GREEN}[COMPLIANT] ICMP outbound stream is tightly restricted or filtered.${NC}"
fi

# --- PHASE 2: PROTOCOL PORT SOCKET MATRIX AUDIT ---
echo -e "\n[Phase 2]: Auditing Outbound Port Sockets Permissions..."

for port in "${COMPLIANCE_PORTS[@]}"; do
    # Using bash native tcp socket interface to probe without heavy tools dependency
    if : 2>/dev/null > /dev/tcp/$TEST_TARGET/$port; then
        echo -e "${RED}[ALERT] Port $port is completely OPEN to external targets! (Egress Leak Vector)${NC}"
    else
        echo -e "${GREEN}[COMPLIANT] Outbound access to Port $port is securely CLOSED/Blocked.${NC}"
    fi
done

echo -e "\n======================================================="
echo "🏁 NETWORK SECURITY EGRESS STANDARDS RUN COMPLETED."
echo "======================================================="
