# 1. Security Group for Public Application Load Balancer (ALB)
resource "aws_security_group" "alb_sg" {
  name        = "prod-alb-security-group"
  description = "Controls inbound traffic to Public Load Balancer"
  vpc_id      = aws_vpc.prod_vpc.id

  # Inbound HTTP from anywhere
  ingress {
    description = "Allow HTTP from Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound HTTPS from anywhere
  ingress {
    description = "Allow HTTPS from Internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound to all destinations
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prod-alb-sg"
    Tier = "Edge-LoadBalancer"
  }
}

# 2. Security Group for Private App Tier (EC2)
resource "aws_security_group" "app_sg" {
  name        = "prod-app-security-group"
  description = "Allows inbound traffic only from the ALB security group"
  vpc_id      = aws_vpc.prod_vpc.id

  # Inbound application traffic strictly from ALB SG
  ingress {
    description     = "Allow HTTP from ALB only"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Outbound traffic (for NAT Gateway updates/patches)
  egress {
    description = "Allow outbound internet via NAT"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "prod-app-sg"
    Tier = "Private-Compute"
  }
}
