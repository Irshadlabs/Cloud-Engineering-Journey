# =========================================================
# Project: AWS High Availability Infrastructure (IaC)
# Author: Mohammed Irshad (AWS SA & CCNA Certified)
# Description: This configuration automates the creation of 
#              an Application Load Balancer (ALB).
# =========================================================

# 1. Create a Security Group for the Load Balancer
# A Load Balancer must allow HTTP traffic (Port 80) from the Internet.
resource "aws_security_group" "alb_sg" {
  name        = "alb-security-group"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open to public web traffic
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Create the Application Load Balancer
resource "aws_lb" "main_alb" {
  name               = "main-web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet.id] # Using your existing subnet

  tags = {
    Name        = "Main-Application-LB"
    Environment = "Production"
  }
}

# 3. Create a Target Group
# This tells the ALB where to send the traffic (to your EC2 instances).
resource "aws_lb_target_group" "web_tg" {
  name     = "web-server-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
