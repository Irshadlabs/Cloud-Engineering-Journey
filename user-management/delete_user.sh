#!/bin/bash

# =========================================================
# Project: Batch User Deletion Tool
# Description: Yeh script list mein diye gaye users ko system
#              se puri tarah remove karti hai.
# =========================================================

USERS=("dev_user" "test_user" "cloud_admin")

echo "--- Starting User Deletion Process ---"

for USERNAME in "${USERS[@]}"
do
    # Check karein ki user system mein maujood hai ya nahi
    if id "$USERNAME" &>/dev/null; then
        
        # User ko delete karna (-r flag ke saath taaki files bhi hat jayein)
        sudo userdel -r "$USERNAME"
        
        # Check karein ki deletion successful raha ya nahi
        if [ $? -eq 0 ]; then
            echo "[SUCCESS] Removed user and home directory: $USERNAME"
        else
            echo "[ERROR] Failed to delete user: $USERNAME"
        fi
    else
        # Agar user pehle se hi nahi hai
        echo "[SKIP] User '$USERNAME' does not exist."
    fi
done

echo "--- User Deletion Completed ---"
