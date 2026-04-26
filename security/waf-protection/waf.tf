# -----------------------------------------------------------------------------------
# Resource: aws_wafv2_web_acl
# Description: Deploys a Web Application Firewall (WAF) with managed rules to 
#              protect the CloudFront distribution from common web exploits.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

resource "aws_wafv2_web_acl" "main_waf" {
  name     = "edge-security-acl"
  scope    = "CLOUDFRONT" # WAF for CloudFront must be in us-east-1
  default_action {
    allow {}
  }

  # 1. Protection against common bad inputs (SQLi, etc.)
  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1
    override_action { none {} }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "CommonRuleSetMetrics"
      sampled_requests_enabled   = true
    }
  }

  # 2. IP Reputation (Blocks known malicious IPs)
  rule {
    name     = "AWSManagedRulesAmazonIpReputationList"
    priority = 2
    override_action { none {} }
    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "IPReputationMetrics"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "MainWAFMetrics"
    sampled_requests_enabled   = true
  }
}

# Output the WAF ARN to link with CloudFront
output "waf_acl_arn" {
  value = aws_wafv2_web_acl.main_waf.arn
}
