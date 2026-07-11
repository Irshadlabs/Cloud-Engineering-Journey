#!/bin/bash
# Enterprise Multi-Container Network Connectivity Diagnostic Tool
# Author: Irshadlabs (2026)

NETWORK_NAME="secure-app_secure_backend_bridge"
WEB_CONTAINER="production_secure_web_app"
CACHE_CONTAINER="production_cache_redis"

echo "=================================================="
echo "      🐳 STARTING DOCKER NETWORK CONNECTIVITY AUDIT "
echo "=================================================="

# 1. Audit Docker Bridge Network Existence
echo -n "[1/3] Verifying Target Network Bridge Existence... "
if docker network inspect "$NETWORK_NAME" > /dev/null 2>&1; then
    echo "✅ FOUND"
else
    echo "❌ ERROR: Target network bridge '$NETWORK_NAME' not found!"
    echo "Remediation: Run 'docker compose up -d' to provision the stack before auditing."
    exit 1
fi

# 2. Extract Internal Container IP Registrations
echo "--------------------------------------------------"
echo "[2/3] Resolving Internal Network Endpoint Topologies:"
echo "--------------------------------------------------"

WEB_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$WEB_CONTAINER" 2>/dev/null)
CACHE_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$CACHE_CONTAINER" 2>/dev/null)

if [ -z "$WEB_IP" ] || [ -z "$CACHE_IP" ]; then
    echo "❌ ERROR: Failed to resolve running container IPs. Ensure containers are active."
    exit 1
else
    echo "Container: $WEB_CONTAINER  -> Internal IP: $WEB_IP"
    echo "Container: $CACHE_CONTAINER -> Internal IP: $CACHE_IP"
fi

# 3. Test Inter-Container Network Route Routing
echo "--------------------------------------------------"
echo "[3/3] Testing Inter-Container Port Routing Pass:"
echo "--------------------------------------------------"

echo "[*] Executing cross-container port check from Web App to Cache Layer (Port 6379)..."
# Execute a non-interactive ping command through the container bridge via Docker Exec
docker exec "$WEB_CONTAINER" node -e "
const net = require('net');
const client = net.createConnection({ port: 6379, host: '$CACHE_CONTAINER', timeout: 2000 }, () => {
    console.log('✅ ROUTE VERIFIED: Web container successfully reached Redis cache layer.');
    process.exit(0);
});
client.on('error', (err) => {
    console.log('❌ ROUTE FAILED: Unable to reach Redis container. Error: ' + err.message);
    process.exit(1);
});
" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "--------------------------------------------------"
    echo "🎯 STATUS: Multi-container network topologies are healthy."
else
    echo "--------------------------------------------------"
    echo "⚠️  STATUS: Network routing failures detected inside the bridge."
    exit 1
fi

echo "=================================================="
