# =========================================================
# Project: Infrastructure Guardrails & Safety
# Author: Mohammed Irshad
# Description: This file implements Lifecycle Rules to 
#              prevent accidental deletion of critical resources.
# =========================================================

# 1. Protect the Production Database
# This ensures that 'terraform destroy' will FAIL if it tries to remove the DB.
resource "aws_db_instance" "safe_db" {
  allocated_storage    = 10
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "SecurePass123!"
  skip_final_snapshot  = true

  # --- THE SAFETY LOCK ---
  lifecycle {
    prevent_destroy = true # This prevents accidental deletion by Terraform
  }

  tags = {
    Name        = "Protected-Production-DB"
    Criticality = "High"
  }
}

# 2. Prevent Downtime during Updates
# This ensures a NEW resource is created BEFORE the old one is deleted.
# Excellent for Web Servers to ensure 100% uptime.
resource "aws_instance" "zero_downtime_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true # Zero-downtime strategy
  }

  tags = {
    Name = "Uptime-Optimized-Server"
  }
}
