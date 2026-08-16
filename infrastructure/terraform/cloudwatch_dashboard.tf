# =========================================================
# Project: Centralized CloudWatch Dashboard (IaC)
# Author: Mohammed Irshad (AWS  Certified)
# Folder: my_cloud_scripts/monitoring
# Description: This script automates a visual dashboard 
#              to monitor EC2 health and ALB traffic in one view.
# =========================================================

resource "aws_cloudwatch_dashboard" "main_dashboard" {
  dashboard_name = "Irshadlabs-Production-Overview"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            [ "AWS/EC2", "CPUUtilization", "InstanceId", "i-0123456789abcdef0" ]
          ]
          period = 300
          stat   = "Average"
          region = "us-east-1"
          title  = "Core Server CPU Utilization"
        }
      },
      {
        type   = "metric"
        x      = 12
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            [ "AWS/ApplicationELB", "RequestCount", "LoadBalancer", "app/main-web-alb/12345" ]
          ]
          period = 300
          stat   = "Sum"
          region = "us-east-1"
          title  = "Inbound Web Traffic (ALB)"
        }
      }
    ]
  })
}
