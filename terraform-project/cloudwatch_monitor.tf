# =========================================================
# Project: AWS CloudWatch Infrastructure Monitoring (IaC)
# Author: Mohammed Irshad (AWS SA Certified)
# Description: This configuration automates the creation of 
#              a CloudWatch Alarm to monitor CPU Utilization.
# =========================================================

# 1. Create a CloudWatch Metric Alarm
# This alarm monitors the 'CPUUtilization' metric of our EC2 instance.
resource "aws_cloudwatch_metric_alarm" "ec2_cpu_alarm" {
  alarm_name                = "High-CPU-Utilization-Alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120" # 2 minutes
  statistic                 = "Average"
  threshold                 = "80"  # Alert if CPU usage is >= 80%
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  # Linking the alarm to your specific EC2 instance ID
  dimensions = {
    InstanceId = aws_instance.web_server.id
  }

  tags = {
    Name        = "CPU-Monitor-Alarm"
    ManagedBy   = "Terraform"
  }
}

# 2. SNS Topic for Notifications (Optional but recommended)
# This is where the alert would be sent (e.g., to your Email).
resource "aws_sns_topic" "user_updates" {
  name = "infrastructure-alerts-topic"
}
