# -----------------------------------------------------------------------------------
# Resource: aws_globalaccelerator_accelerator
# Description: Deploys a Global Accelerator to provide static Anycast IP addresses 
#              and route traffic over the AWS global network for ultra-low latency.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

# 1. Create the Global Accelerator
resource "aws_globalaccelerator_accelerator" "main" {
  name            = "irshadlabs-global-hub"
  ip_address_type = "IPV4"
  enabled         = true

  attributes {
    flow_logs_enabled   = true
    flow_logs_s3_bucket = "irshadlabs-logs-bucket"
  }
}

# 2. Add a Listener (Port 80/443)
resource "aws_globalaccelerator_listener" "web_listener" {
  accelerator_arn = aws_globalaccelerator_accelerator.main.id
  client_affinity = "NONE"
  protocol        = "TCP"

  port_range {
    from_port = 80
    to_port   = 80
  }
}

# 3. Connect to your Application Load Balancer (ALB)
resource "aws_globalaccelerator_endpoint_group" "region_hub" {
  listener_arn = aws_globalaccelerator_listener.web_listener.id

  endpoint_configuration {
    endpoint_id = var.alb_arn # Link to your Day 56 ALB
    weight      = 100
  }
}

# Output the Static IPs (Your new Global Identity)
output "accelerator_ips" {
  value = aws_globalaccelerator_accelerator.main.ip_sets
}
