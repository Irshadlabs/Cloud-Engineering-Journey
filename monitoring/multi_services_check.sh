#!/bin/bash

# =========================================================
# Project: Multi-Service Health Monitor
# Author: Mohammed Irshad
# Description: This script iterates through a list of Linux 
#              services and checks their current status.
# =========================================================

# Define an array containing the names of services to monitor

SERVICES=("ssh" "cron" "dbus")

echo "--- Starting Bulk Service Status Check ---"

# Start a 'for' loop to process each service in the list
for SERVICE in "${SERVICES[@]}"
do
    # Use systemctl to check if the service is active
    # --quiet flag prevents the command from printing extra output
    if systemctl is-active  $SERVICE; then
        # If the exit status is 0, the service is running
        echo "[OK] Service '$SERVICE' is currently RUNNING."
    else
        # If the exit status is non-zero, the service is stopped or failed
        echo "[ERROR] Service '$SERVICE' is NOT RUNNING!"
    fi
done

echo "--- All service checks are completed ---"
