#!/bin/bash

# =========================================================
# Project: Batch User Creation Tool
# Author: Mohammed Irshad
# Description: This script automates the creation of multiple 
#              users from a predefined list.
# =========================================================

# List of new team members 
USERS=("dev_user" "test_user" "cloud_admin")

echo "--- Starting User Onboarding Process ---"

# Loop through each name in the list
for USERNAME in "${USERS[@]}"
do
    # Check if the user already exists in the system
    if id "$USERNAME" &>/dev/null; then
        echo "[SKIP] User '$USERNAME' already exists."
    else
        # Create a new user with a home directory
        sudo useradd -m "$USERNAME"
        
        # Check if user creation was successful
        if [ $? -eq 0 ]; then
            echo "[SUCCESS] Created user: $USERNAME"
            # Set a default password (optional, user should change it on first login)
            echo "$USERNAME:TempPass123" | sudo chpasswd
        else
            echo "[ERROR] Failed to create user: $USERNAME"
        fi
    fi
done

echo "--- User Onboarding Completed ---"
