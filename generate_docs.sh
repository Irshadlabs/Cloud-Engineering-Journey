#!/bin/bash

cat <<EOF > SCRIPT-DESCRIPTIONS.md
# ☁️ Cloud Engineering & DevOps Scripts descriptions
This document is auto-generated to keep track of the scripts and tools in this repository.

## 📁 Repository Overview
Generated on: $(date)

## 🛠️ Main Projects & Scripts
- **AWS Automation:** Scripts for cost-saving and management (e.g., \`ebs_cost_saver.py\`).
- **Infrastructure as Code:** Terraform configurations for automated provisioning.
- **Containerization:** Docker and Kubernetes projects.
- **Monitoring & Ops:** System health and disk logging tools.

## 📂 Full Directory Structure
EOF

# Directories ko clean format mein append karna
tree -L 2 >> SCRIPT-DESCRIPTIONS.md || ls -R | grep ":$" >> SCRIPT-DESCRIPTIONS.md

echo "Documentation updated successfully in SCRIPT-DESCRIPTIONS.md!"
