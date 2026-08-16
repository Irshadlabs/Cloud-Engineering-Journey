#!/bin/bash

# 1. Variables define 
SOURCE_DIR="/home/irshad/my_cloud_scripts"
BACKUP_DIR="/home/irshad/backups"
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_FILE="backup_$TIMESTAMP.tar.gz"

# 2. Backup directory check  (if not available then create)
[ ! -d "$BACKUP_DIR" ] && mkdir -p "$BACKUP_DIR"

# 3. Backup process start with tar command.
echo "Starting backup of $SOURCE_DIR..."
tar -czf "$BACKUP_DIR/$BACKUP_FILE" "$SOURCE_DIR"

# 4. Status check
if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_DIR/$BACKUP_FILE"
else
    echo "Backup failed!"
fi

# 5. delete old backup (Retention Policy - 7 days oldere)
find "$BACKUP_DIR" -type f -mtime +7 -name "*.tar.gz" -exec rm {} \;
echo "Old backups cleaned up."
