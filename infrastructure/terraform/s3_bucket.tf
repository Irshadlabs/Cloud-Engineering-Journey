# =========================================================
# Project: AWS Infrastructure as Code (IaC)
# Author: Mohammed Irshad
# Description: This Terraform configuration automates the 
#              creation of a secure S3 Bucket for storage.
# =========================================================

# 1. Define the Cloud Provider (AWS)
# This block tells Terraform to use the AWS plugin and sets the deployment region.

# 2. Create an S3 Bucket Resource
# 'my_portfolio_bucket' is the internal name used by Terraform to track this resource.
resource "aws_s3_bucket" "my_portfolio_bucket" {
  
  # The 'bucket' name must be globally unique across all AWS accounts worldwide.
  bucket = "irshadlabs-terraform-bucket-2026"

  # Resource Tags: Essential for cost tracking and environment organization in Cloud.
  tags = {
    Name        = "My-Portfolio-Storage"
    Environment = "Development"
    Project     = "Cloud-Automation"
    ManagedBy   = "Terraform"
  }
}

# 3. Security Configuration: Public Access Block
# As an AWS Architect, I am implementing this to ensure the bucket is NOT public.
# This follows the "Security Best Practices" to prevent accidental data leaks.
resource "aws_s3_bucket_public_access_block" "security_block" {
  bucket = aws_s3_bucket.my_portfolio_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
