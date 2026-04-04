# =========================================================
# Project: Infrastructure Governance & Tagging
# Author: Mohammed Irshad
# Description: This file implements standardized tagging 
#              to improve cost tracking and organization.
# =========================================================

# 1. Define Local Variables for Tags
# This acts as a single "Source of Truth" for your company's labels.
locals {
  common_tags = {
    Project     = "Cloud-Automation-2026"
    ManagedBy   = "Terraform"
    Owner       = "Irshadlabs"
    Environment = "Development"
    BusinessUnit = "DevOps-Core"
  }
}

# 2. Example: Applying these tags to a New Resource
# Instead of typing tags 5 times, we just "merge" them.
resource "aws_s3_bucket" "log_bucket" {
  bucket = "irshad-central-logs-2026"

  # This is the 'Magic' line that applies all tags at once
  tags = local.common_tags
}

# 3. Output the Project Name
output "current_project" {
  value = local.common_tags["Project"]
}
