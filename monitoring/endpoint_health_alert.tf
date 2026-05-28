# -----------------------------------------------------------------------------------
# Resource: aws_route53_health_check & aws_cloudwatch_metric_alarm
# Description: Automates public service endpoint monitoring. Triggers an SNS
#              alert if the target API system goes offline or returns errors.
# Author:      Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

# 1. Reference or Create the Core Operational Notification SNS Topic
resource "aws_sns_topic" "endpoint_alerts" {
  name = "infrastructure-endpoint-failure-alerts"
}

# 2. Configure Route53 Global Health Check for the Application Endpoint
resource "aws_route53_health_check" "api_health_check" {
  fqdn              = "api.example.com" # Replace with your production domain endpoint
  port              = 443
  type              = "HTTPS"
  resource_path     = "/health" # Endpoint checking the application's internal database/service state
  failure_threshold = "3"       # Triggers error state after 3 consecutive connection failures
  request_interval  = "30"      # Time interval in seconds between standard probe checks

  tags = {
    Name        = "Production-API-Gateway-Watchdog"
    Environment = "Production"
  }
}

# 3. CloudWatch Metric Alarm Linking Route53 Status to Notification Plane
resource "aws_cloudwatch_metric_alarm" "route53_alarm" {
  alarm_name          = "Route53-Endpoint-Down-Alert"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "HealthCheckStatus"
  namespace           = "AWS/Route53"
  period              = "60"
  statistic           = "Minimum"
  threshold           = "1" # 1 means Healthy, 0 means Endpoint is down
  alarm_description   = "This metric triggers an alert immediately if the global Route53 path probe reports target endpoint failure."
  
  alarm_actions       = [aws_sns_topic.endpoint_alerts.arn]

  dimensions = {
    HealthCheckId = aws_route53_health_check.api_health_check.id
  }
}
