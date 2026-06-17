#!/bin/bash
# =========================================================
# Project: Infrastructure Drift Auditor
# Author: Mohammed Irshad (AWS  Certified)
# Description: This script checks if the manual changes 
#              match the Terraform code.
# =========================================================

echo "Starting Drift Detection for Irshadlabs Infrastructure..."
terraform plan -detailed-exitcode > /dev/null

if [ $? -eq 2 ]; then
  echo "[ALERT] Drift Detected! Manual changes found in AWS Console."
  echo "Run 'terraform apply' to fix the infrastructure and match the code."
else
  echo "[SAFE] No drift detected. Infrastructure matches the code."
fi
