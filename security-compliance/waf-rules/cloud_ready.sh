#!/bin/bash

# =========================================================
# Project: Cloud Readiness Checker
# Author: Mohammed Irshad
# Description: This script checks if the system is ready 
#              for Cloud Operations.
# =========================================================

echo "Starting Cloud Readiness Check..."
echo "---------------------------------"

# 1. Check Internet Connectivity
# We ping Google's DNS to see if we are online
ping -c 2 8.8.8.8 > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "[OK] Internet is connected."
else
    echo "[ERROR] No internet! Please check your connection."
fi

# 2. Find Public IP Address
echo "Fetching your Public IP..."
PUBLIC_IP=$(curl -s https://ifconfig.me)
echo "Your Public IP is: $PUBLIC_IP"

# 3. Check for SSH Keys
if [ -f ~/.ssh/id_rsa ]; then
    echo "[OK] SSH keys found. You can connect to cloud servers."
else
    echo "[WARNING] SSH keys not found. Recommendation: Run 'ssh-keygen'."
fi

echo "---------------------------------"
echo "Check Complete!"
