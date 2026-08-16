# =========================================================
# Project: Infrastructure Output Definitions
# Author: Mohammed Irshad (AWS SA Certified)
# Description: This file defines the outputs that Terraform 
#              will display after a successful deployment.
# =========================================================

# 1. Output the Public IP of the EC2 Instance
# Essential for SSH access and manual verification.
output "web_server_public_ip" {
  description = "The public IP address of the main web server"
  value       = aws_instance.web_server.public_ip
}

# 2. Output the Application Load Balancer DNS Name
# This is the URL you share with users to access your website.
output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.main_alb.dns_name
}

# 3. Output the S3 Bucket Name
# Useful for developers who need to know where to upload files.
output "s3_bucket_name" {
  description = "The name of the S3 bucket created for storage"
  value       = aws_s3_bucket.my_portfolio_bucket.id
}

# 4. Output the VPC ID
# Important for connecting other networks or peering.
output "vpc_identifier" {
  description = "The ID of the production VPC"
  value       = aws_vpc.main_vpc.id
}

