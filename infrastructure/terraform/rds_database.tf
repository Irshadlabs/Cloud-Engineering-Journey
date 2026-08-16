# =========================================================
# Project: AWS RDS Database Automation (IaC)
# Author: Mohammed Irshad
# Description: This configuration automates the deployment 
#              of a managed MySQL RDS instance.
# =========================================================

# 1. Create a Database Security Group
# Standard MySQL port is 3306. We restrict access for security.
resource "aws_security_group" "db_sg" {
  name        = "rds-database-sg"
  description = "Allow MySQL traffic"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    # CCNA Tip: In production, only allow traffic from the Web EC2 Security Group
    cidr_blocks = ["10.0.0.0/16"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Deploy the RDS MySQL Instance
# This provides a managed database with automated backups.
resource "aws_db_instance" "production_db" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro" # Free Tier eligible
  db_name              = "irshadlabsdb"
  username             = "admin"
  password             = "Password123!" # In real world, use Secrets Manager
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible  = false # Database should stay private

  vpc_security_group_ids = [aws_security_group.db_sg.id]

  tags = {
    Name        = "Main-RDS-Instance"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}
