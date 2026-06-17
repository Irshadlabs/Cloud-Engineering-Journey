# -----------------------------------------------------------------------------------
# Resource: aws_backup_plan & aws_backup_vault
# Description: Automates the creation of a centralized backup strategy to ensure 
#              data durability and disaster recovery compliance.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

# 1. Create a Secure Backup Vault
resource "aws_backup_vault" "main_vault" {
  name        = "production-recovery-vault"
  
  tags = {
    Environment = "Production"
    Purpose     = "Disaster-Recovery"
  }
}

# 2. Define the Backup Plan (Schedule and Retention)
resource "aws_backup_plan" "daily_backup" {
  name = "daily-infrastructure-backup"

  rule {
    rule_name         = "daily_midnight_backup"
    target_vault_name = aws_backup_vault.main_vault.name
    schedule          = "cron(0 0 * * ? *)" # Every night at 00:00 UTC

    lifecycle {
      delete_after = 30 # Keep backups for 30 days
    }
  }
}

# 3. Assign Resources to the Plan (Based on Tags)
resource "aws_backup_selection" "tagged_resources" {
  iam_role_arn = var.backup_iam_role_arn
  name         = "backup-resources-with-backup-tag"
  plan_id      = aws_backup_plan.daily_backup.id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = "Backup"
    value = "True"
  }
}
