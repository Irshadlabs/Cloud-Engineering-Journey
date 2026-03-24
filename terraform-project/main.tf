# =========================================================
# Project: Terraform Infrastructure Launch
# Author: Mohammed Irshad
# Description: This script automates the creation of an
#              AWS EC2 instance using Terraform.
# =========================================================

provider "aws" {
  region = "us-east-1" # Aap apni region yahan dal sakte hain
}

resource "aws_instance" "my_web_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu AMI ID
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform-Managed-Server"
  }
}
