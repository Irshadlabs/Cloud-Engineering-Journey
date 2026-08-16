# -----------------------------------------------------------------------------------
# Resource: aws_prometheus_rule_group_namespace
# Description: Configures alerting rules in AWS Prometheus to trigger notifications 
#              when system thresholds (CPU/Memory) are breached.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

# 1. Create an SNS Topic for Alerts (The Notification Channel)
resource "aws_sns_topic" "infrastructure_alerts" {
  name = "eks-critical-alerts"
}

# 2. Add an Email Subscription (Replace with your email)
resource "aws_sns_topic_subscription" "email_target" {
  topic_arn = aws_sns_topic.infrastructure_alerts.arn
  protocol  = "email"
  endpoint  = "your-email@example.com" 
}

# 3. Define the Alerting Rules in Prometheus
resource "aws_prometheus_rule_group_namespace" "eks_rules" {
  name         = "infrastructure-rules"
  workspace_id = aws_prometheus_workspace.eks_monitor.id # From Day 82
  data         = <<EOF
groups:
  - name: EKSPerformanceAlerts
    rules:
      - alert: HighCpuUsage
        expr: node_cpu_utilisation > 80
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "High CPU usage detected on node"
          description: "Node CPU has been above 80% for more than 5 minutes."
EOF
}

