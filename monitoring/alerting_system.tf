# -----------------------------------------------------------------------------------
# Resource: aws_cloudwatch_metric_alarm
# Description: Automates infrastructure monitoring by creating an alarm that 
#              triggers an SNS notification if CPU usage exceeds 80%.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

# 1. Create SNS Topic for Alerts
resource "aws_sns_topic" "sysadmin_alerts" {
  name = "infrastructure-critical-alerts"
}

# 2. Subscribe your Email to the Topic
# Note: You will need to click 'Confirm Subscription' in your email inbox
resource "aws_sns_topic_subscription" "email_target" {
  topic_arn = aws_sns_topic.sysadmin_alerts.arn
  protocol  = "email"
  endpoint  = "your-email@example.com" # Replace with your real email
}

# 3. Create CloudWatch Metric Alarm
resource "aws_cloudwatch_metric_alarm" "cpu_high_alarm" {
  alarm_name          = "High-CPU-Utilization-Alert"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization"
  
  alarm_actions       = [aws_sns_topic.sysadmin_alerts.arn]

  dimensions = {
    InstanceId = "i-0123456789abcdef0" # Replace with your real Instance ID
  }
}
