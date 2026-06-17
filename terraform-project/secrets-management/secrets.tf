# -----------------------------------------------------------------------------------
# Resource: aws_secretsmanager_secret
# Description: Automates the creation of a secure vault to store sensitive DB 
#              credentials, replacing hardcoded passwords in the infrastructure.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

# 1. Create the Secret Container
resource "aws_secretsmanager_secret" "db_credentials" {
  name        = "production/irshadlabs/db-password"
  description = "Managed by Terraform: Secure store for RDS credentials"
  
  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Security    = "High"
  }
}

# 2. Define the Secret Value (JSON Format)
resource "aws_secretsmanager_secret_version" "db_secret_val" {
  secret_id     = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    username = "admin_irshad"
    password = "SuperSecretPassword2026!" # In production, this can be randomly generated
  })
}

# 3. Output the Secret ARN (for other resources like RDS to use)
output "secret_arn" {
  description = "The ARN of the secret to be used by the application"
  value       = aws_secretsmanager_secret.db_credentials.arn
}
