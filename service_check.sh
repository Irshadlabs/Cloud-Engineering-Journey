#!/bin/bash

# =========================================================
# Project: Service Health Checker
# Description: Checks if a specific service is running.
# =========================================================

# Name of the service to check
SERVICE="ssh"

echo "Checking the status of: $SERVICE"

# Check if the service is currently active
if systemctl is-active --quiet $SERVICE; then
    # Message if the service is running
    echo "SUCCESS: $SERVICE is running."
else
    # Message if the service is not running
    echo "ALERT: $SERVICE is NOT running!"
    echo "Please run: sudo systemctl start $SERVICE"
fi

echo "Check completed."
