#!/bin/bash

# =========================================================
# Project: Local Port Scanner (Security Audit)
# Author: Mohammed Irshad
# Description: This script checks if common ports (SSH, HTTP) 
#              are open and listening on the server.
# =========================================================

# List of common ports to check
# 22: SSH, 80: HTTP, 443: HTTPS
PORTS=(22 80 443)
HOST="localhost"

echo "--- Starting Security Port Audit ---"

for PORT in "${PORTS[@]}"
do
    # Using 'nc' (netcat) to check the port status
    # -z: scan mode, -w 1: timeout of 1 second
    nc -z -w 1 $HOST $PORT > /dev/null 2>&1
    
    if [ $? -eq 0 ]; then
        echo "[OPEN] Port $PORT is active and listening."
    else
        echo "[CLOSED] Port $PORT is not active."
    fi
done

echo "--- Audit Finished ---"
