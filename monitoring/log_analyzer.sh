#!/bin/bash
# -----------------------------------------------------------------------------------
# Script: log_analyzer.sh
# Description: Automatically parses Nginx/Apache logs to identify traffic patterns
#              and HTTP error codes (4xx, 5xx).
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

# Path to your log file (Example path)
LOG_FILE="/var/log/nginx/access.log"

# Check if log file exists
if [ ! -f "$LOG_FILE" ]; then
    echo "[ERROR] Log file not found at $LOG_FILE"
    exit 1
fi

echo "--- Web Traffic Analysis Report ---"
echo "Report Generated on: $(date)"
echo "-----------------------------------"

# 1. Total Requests
total_req=$(wc -l < "$LOG_FILE")
echo "Total Requests Processed: $total_req"

# 2. Count HTTP 404 Errors (Client Side Errors)
not_found=$(grep " 404 " "$LOG_FILE" | wc -l)
echo "HTTP 404 Errors: $not_found"

# 3. Count HTTP 500 Errors (Server Side Errors)
server_error=$(grep " 500 " "$LOG_FILE" | wc -l)
echo "HTTP 500 Errors: $server_error"

# 4. Top 5 IP Addresses hitting the server
echo "-----------------------------------"
echo "Top 5 Client IP Addresses:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5

echo "-----------------------------------"
echo "Analysis Complete."
