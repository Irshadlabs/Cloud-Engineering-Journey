# =========================================================
# Project: EC2 Instance Deployment (IaC)
# Author: Mohammed Irshad (AWS SA Certified)
# Description: This configuration launches an EC2 instance 
#              specifically inside the Public Subnet of our VPC.
# =========================================================

# 1. Create a Security Group for the Web Server
# This acts as a firewall, allowing SSH (Port 22) for management.
resource "aws_security_group" "web_sg" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.main_vpc.id # Linking to our VPC

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # CCNA Skill: Open to all for practice
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Launch the EC2 Instance
resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Standard Ubuntu 22.04 AMI
  instance_type = "t2.micro"              # Free Tier eligible

  # Linking the instance to our Subnet and Security Group
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name        = "Terraform-Web-Server"
    Project     = "Automation-Portfolio"
    ManagedBy   = "Terraform"
  }
}
