# =========================================================
# Project: Dockerized Nginx Web Server
# Author: Mohammed Irshad 
# Description: This Dockerfile creates a high-performance, 
#              lightweight container to host web content.
# =========================================================

# Step 1: Use the official Nginx image based on Alpine Linux
# 'Alpine' is used because it is extremely small and secure.
FROM nginx:alpine

# Step 2: Set the Working Directory (Standard Practice)
WORKDIR /usr/share/nginx/html

# Step 3: Metadata - Labeling the image for better management
LABEL maintainer="Irshadlabs"
LABEL version="1.0"
LABEL description="Production-ready Nginx Container"

# Step 4: Expose Port 80
# This informs Docker that the container listens on port 80 at runtime.
EXPOSE 80

# Step 5: Start the Nginx Server
# CMD specifies the default command to execute when the container starts.
CMD ["nginx", "-g", "daemon off;"]
