#
 -----------------------------------------------------------------------------------
# Resource: aws_ec2_transit_gateway
# Description: Implements a centralized Transit Gateway (TGW) to simplify 
#              multi-VPC connectivity and eliminate the complexity of VPC peering meshes.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

# 1. Create the Transit Gateway
resource "aws_ec2_transit_gateway" "hub" {
  description                     = "Centralized Hub for Dev and Prod VPCs"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = {
    Name        = "main-transit-gateway-hub"
    Environment = "Infrastructure-Core"
    ManagedBy   = "Terraform"
  }
}

# 2. Attach Development VPC to the Hub
resource "aws_ec2_transit_gateway_vpc_attachment" "dev_attachment" {
  subnet_ids         = var.dev_subnet_ids
  transit_gateway_id = aws_ec2_transit_gateway.hub.id
  vpc_id             = var.dev_vpc_id

  tags = {
    Name = "tgw-attachment-dev-vpc"
  }
}

# 3. Attach Production VPC to the Hub
resource "aws_ec2_transit_gateway_vpc_attachment" "prod_attachment" {
  subnet_ids         = var.prod_subnet_ids
  transit_gateway_id = aws_ec2_transit_gateway.hub.id
  vpc_id             = var.prod_vpc_id

  tags = {
    Name = "tgw-attachment-prod-vpc"
  }
}
