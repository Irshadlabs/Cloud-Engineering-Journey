#!/bin/bash
#!/bin/bash
echo "--- Server Health Report ---"
date
echo -e "\n1. Disk Usage:"
df -h | grep '^/dev/'
echo -e "\n2. Memory Usage:"
free -h
echo -e "\n3. System Uptime:"
uptime
script run succesfully
# Updated on Mon Feb 23 03:55:12 UTC 2026 with correct email config
#!/bin/bash
# Log file path
LOG_FILE="/home/irshad/my_cloud_scripts/server_usage.log"

echo "----------------------------" >> $LOG_FILE
date >> $LOG_FILE
echo "Disk Usage:" >> $LOG_FILE
df -h | grep '^/dev/' >> $LOG_FILE
echo "Memory Usage:" >> $LOG_FILE
free -h >> $LOG_FILE
