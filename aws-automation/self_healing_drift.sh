#!/bin/bash
# -----------------------------------------------------------------------------------
# Script: self_healing_drift.sh
# Description: Automatically detects infrastructure drift and reconciles it by 
#              re-applying Terraform configurations. Ensures state consistency.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

LOG_FILE="/tmp/drift_remediation.log"

echo "[$(date)] Starting Drift Audit..." | tee -a $LOG_FILE

# 1. Check for drift (Exit code 2 means drift detected)
terraform plan -detailed-exitcode > /dev/null 2>&1
DRIFT_STATUS=$?

if [ $DRIFT_STATUS -eq 2 ]; then
    echo "[ALERT] Drift detected! Manual changes found in AWS." | tee -a $LOG_FILE
    echo "[ACTION] Initiating automated remediation..." | tee -a $LOG_FILE
    
    # 2. Re-apply configuration to fix the drift automatically
    terraform apply -auto-approve >> $LOG_FILE 2>&1
    
    if [ $? -eq 0 ]; then
        echo "[SUCCESS] Infrastructure has been restored to its defined state." | tee -a $LOG_FILE
    else
        echo "[ERROR] Remediation failed. Check logs for details." | tee -a $LOG_FILE
    fi
elif [ $DRIFT_STATUS -eq 0 ]; then
    echo "[OK] No drift detected. Infrastructure is consistent with code." | tee -a $LOG_FILE
else
    echo "[ERROR] Terraform plan failed. Check credentials/connectivity." | tee -a $LOG_FILE
fi

echo "------------------------------------------------" >> $LOG_FILE
