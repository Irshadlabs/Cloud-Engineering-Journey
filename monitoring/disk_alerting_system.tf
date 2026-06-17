# -----------------------------------------------------------------------------------
# Resource: aws_cloudwatch_metric_alarm (Disk Space Alerting)
# Description: Automates volume storage monitoring by triggering an SNS 
#              notification if free disk space drops below 20%.
# Author:      Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

# 1. Create a dedicated SNS Topic for Storage Diagnostics
resource "aws_sns_topic" "storage_alerts" {
  name = "infrastructure-disk-space-alerts"
}

# 2. Subscribe your Operational Email to the Topic
# Note: AWS will send a confirmation email that requires manual approval
resource "aws_sns_topic_subscription" "storage_email_target" {
  topic_arn = aws_sns_topic.storage_alerts.arn
  protocol  = "email"
  endpoint  = "your-email@example.com" # Replace with your corporate email
}

# 3. Create CloudWatch Metric Alarm for Disk Space Utilization
resource "aws_cloudwatch_metric_alarm" "disk_low_alarm" {
  alarm_name          = "Low-Disk-Space-Utilization-Alert"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "DiskSpaceUtilization"
  namespace           = "CWAgent" # Standard AWS CloudWatch Agent Namespace
  period              = "300"
  statistic           = "Average"
  threshold           = "20" # Alert triggers if free space drops to or below 20%
  alarm_description   = "This metric monitors the root volume partition disk utilization thresholds."
  
  alarm_actions       = [aws_sns_topic.storage_alerts.arn]

  dimensions = {
    InstanceId = "i-0123456789abcdef0" # Replace with your active EC2 Instance ID
    path       = "/"
    device     = "xvda"
  }
}
