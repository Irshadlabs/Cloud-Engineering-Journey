# -----------------------------------------------------------------------------------
# Resource: aws_acm_certificate & aws_acm_certificate_validation
# Description: Automates the issuance and DNS validation of SSL/TLS certificates 
#              to enable secure HTTPS communication for the infrastructure.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

# 1. Request a Public SSL Certificate
resource "aws_acm_certificate" "site_ssl" {
  domain_name       = "irshadlabs.com"
  validation_method = "DNS"

  tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# 2. Automated DNS Validation (Connecting with Route 53)
# This creates the hidden record that proves you own the domain.
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.site_ssl.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.hosted_zone_id # From your Day 61 Route 53 setup
}

# 3. Final Validation Trigger
resource "aws_acm_certificate_validation" "cert_complete" {
  certificate_arn         = aws_acm_certificate.site_ssl.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}
