# =========================================================
# Project: Terraform Infrastructure Variables
# Author: Mohammed Irshad 
# Description: This file defines all input variables to 
#              make the infrastructure reusable and clean.
# =========================================================

variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the Production VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_type" {
  description = "EC2 Instance type for web servers"
  type        = string
  default     = "t2.micro"
}

variable "project_name" {
  description = "Name of the project for tagging"
  type        = string
  default     = "Cloud-Automation-Portfolio"
}
