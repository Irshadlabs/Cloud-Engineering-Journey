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
