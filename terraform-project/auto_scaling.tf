# =========================================================
# Project: Self-Healing & Automated Scaling (IaC)
# Author: Mohammed Irshad (AWS SA Certified)
# Description: This configuration ensures that at least 2 
#              web servers are always running and healthy.
# =========================================================

# 1. Create a Launch Template
# This is the "Blueprint" for your servers.
resource "aws_launch_template" "web_template" {
  name_prefix   = "irshadlabs-web-template"
  image_id      = "ami-0c55b159cbfafe1f0" # Ubuntu 22.04
  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.web_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name   = "ASG-Web-Server"
      Backup = "True" # Linking to your Day 41 Backup Policy!
    }
  }
}

# 2. Create the Auto Scaling Group (ASG)
# This is the "Manager" that monitors your servers.
resource "aws_autoscaling_group" "web_asg" {
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1
  vpc_zone_identifier = [aws_subnet.public_subnet.id]

  launch_template {
    id      = aws_launch_template.web_template.id
    version = "$Latest"
  }

  health_check_type         = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Environment"
    value               = "Production"
    propagate_at_launch = true
  }
}
