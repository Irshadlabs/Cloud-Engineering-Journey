# -----------------------------------------------------------------------------------
# Resource: aws_vpc_peering_connection
# Description: Establishes a secure peering connection between two independent 
#              VPCs to enable private cross-network communication.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

# 1. Define the Peering Connection
resource "aws_vpc_peering_connection" "dev_to_prod" {
  peer_vpc_id   = var.prod_vpc_id # Target VPC ID
  vpc_id        = var.dev_vpc_id  # Source VPC ID
  auto_accept   = true

  tags = {
    Name        = "internal-dev-to-prod-peering"
    Environment = "Infrastructure-Core"
    ManagedBy   = "Terraform"
  }
}

# 2. Update Route Tables (Important for Traffic Flow)
# This allows traffic from Dev VPC to reach Prod VPC
resource "aws_route" "dev_to_prod_route" {
  route_table_id            = var.dev_route_table_id
  destination_cidr_block    = "10.1.0.0/16" # Prod VPC CIDR
  vpc_peering_connection_id = aws_vpc_peering_connection.dev_to_prod.id
}

# 3. Variable definitions for clean architecture
variable "dev_vpc_id" {}
variable "prod_vpc_id" {}
variable "dev_route_table_id" {}
