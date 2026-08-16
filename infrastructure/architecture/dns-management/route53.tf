# -----------------------------------------------------------------------------------
# Resource: aws_route53_zone & aws_route53_record
# Description: Automates the creation of a DNS Hosted Zone and maps the Application 
#              Load Balancer (ALB) to a custom domain name.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

# 1. Create a Public Hosted Zone
resource "aws_route53_zone" "primary" {
  name    = "irshadlabs.com" # Replace with your actual domain name
  comment = "Managed by Terraform - Production DNS"

  tags = {
    Environment = "Production"
    Project     = "Cloud-Platform"
  }
}

# 2. Create an Alias Record pointing to the Load Balancer
# This is better than a CNAME because it's free and faster in AWS.
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "www.irshadlabs.com"
  type    = "A"

  alias {
    name                   = var.alb_dns_name # Linking your ALB from yesterday
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}

# Variable for ALB details (Integration with existing scripts)
variable "alb_dns_name" {}
variable "alb_zone_id" {}
