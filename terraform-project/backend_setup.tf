# =========================================================
# Project: Terraform Remote State Management
# Author: Mohammed Irshad
# Description: This configuration moves the Terraform State 
#              from local machine to AWS S3 for better security.
# =========================================================

# 1. Configure the Remote Backend
# This block ensures that your infrastructure 'Memory' is stored in the Cloud.
terraform {
  backend "s3" {
    # Replace this with your unique bucket name created in Day 18
    bucket         = "irshadlabs-terraform-bucket-2026"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    
    # Optional: Enable encryption to protect your state data
    encrypt        = true
  }
}

# 2. Output to verify where the state is being stored
output "backend_status" {
  value = "Terraform State is now securely stored in S3 Bucket: irshadlabs-terraform-bucket-2026"
}
