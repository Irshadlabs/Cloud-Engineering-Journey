#!/bin/bash
# -----------------------------------------------------------------------------------
# Script Name: docker_cleaner.sh
# Description: Safely cleans up dangling images, stopped containers, and unused 
#              networks to reclaim system disk space.
# Author: Mohammed Irshad (Cloud & DevOps Specialist)
# -----------------------------------------------------------------------------------

echo "===================================================="
echo "      🧹 STARTING DOCKER DISK CLEANUP               "
echo "===================================================="

# 1. Stop all running containers (Optional - commenting out for safety)
# echo "Stopping running containers..."
# docker stop $(docker ps -a -q)

# 2. Remove stopped containers
echo -e "\n[1] Removing stopped containers..."
docker container prune -f

# 3. Remove dangling images (Images without tags)
echo -e "\n[2] Removing dangling images..."
docker image prune -f

# 4. Remove unused networks
echo -e "\n[3] Removing unused docker networks..."
docker network prune -f

# 5. Check remaining disk space used by Docker
echo -e "\n[4] Current Docker Disk Usage:"
docker system df

echo -e "\n===================================================="
echo "      🎯 SYSTEM CLEANUP COMPLETED                   "
echo "===================================================="
