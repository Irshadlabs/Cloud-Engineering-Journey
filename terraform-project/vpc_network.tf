# =========================================================
# Project: Automated VPC Networking (IaC)
# Author: Mohammed Irshad (AWS SA & CCNA Certified)
# Description: This configuration automates the creation of 
#              a Custom VPC with a specific CIDR block.
# =========================================================

# 1. Create a Custom VPC
# This provides an isolated network for cloud resources.
resource "aws_vpc" "main_vpc" {
  # Standard CIDR block for a large network (65,536 IPs)
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name        = "Production-VPC"
    Environment = "Prod"
    ManagedBy   = "Terraform"
    CreatedBy   = "Irshadlabs"
  }
}

# 2. Create a Public Subnet inside the VPC
# This subnet will host public-facing resources like Web Servers.
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24" # 256 available IP addresses

  tags = {
    Name = "Public-Subnet-01"
  }
}

# 3. Internet Gateway Configuration
# This enables communication between the VPC and the Internet.
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Main-Internet-Gateway"
  }
}
