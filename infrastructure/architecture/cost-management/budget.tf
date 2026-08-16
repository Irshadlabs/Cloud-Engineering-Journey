# -----------------------------------------------------------------------------------
# Resource: aws_budgets_budget
# Description: Sets up a monthly cost budget alert for the AWS account. Sends an 
#              automated email notification if the forecasted or actual cost 
#              crosses 80% of the threshold.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

resource "aws_budgets_budget" "account_budget" {
  name              = "irshadlabs-monthly-budget"
  budget_type       = "COST"
  limit_amount      = "50" # Your monthly limit in USD (Change as needed)
  limit_unit        = "USD"
  time_period_start = "2026-05-01_00:00"
  time_unit         = "MONTHLY"

  # Notification when actual or forecasted cost exceeds 80% of budget ($40)
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = ["your-email@example.com"] # Replace with your email
  }
}
