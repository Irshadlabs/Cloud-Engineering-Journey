# =========================================================
# Project: AWS IAM Security Automation (IaC)
# Author: Mohammed Irshad 
# Description: This configuration creates a restricted IAM 
#              User with Read-Only access to S3.
# =========================================================

# 1. Create a New IAM User
# Standard practice is to create individual users instead of sharing root keys.
resource "aws_iam_user" "dev_user" {
  name = "irshad-dev-auditor"

  tags = {
    Role        = "Auditor"
    Environment = "Production"
  }
}

# 2. Attach a Managed Read-Only Policy
# We are using the "AmazonS3ReadOnlyAccess" policy provided by AWS.
# This follows the "Principle of Least Privilege" (POLP).
resource "aws_iam_user_policy_attachment" "s3_readonly" {
  user       = aws_iam_user.dev_user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

# 3. Create Access Keys for the User
# Note: In a real scenario, keys are managed securely and not displayed in logs.
resource "aws_iam_access_key" "dev_user_key" {
  user = aws_iam_user.dev_user.name
}
