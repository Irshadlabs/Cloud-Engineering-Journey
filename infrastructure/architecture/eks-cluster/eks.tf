# -----------------------------------------------------------------------------------
# Resource: aws_eks_cluster & aws_eks_node_group
# Description: Automates the deployment of a managed Kubernetes (EKS) cluster 
#              and a scalable worker node group for container orchestration.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

# 1. Create EKS Cluster Control Plane
resource "aws_eks_cluster" "main" {
  name     = "irshadlabs-eks-cluster"
  role_arn = var.eks_iam_role_arn

  vpc_config {
    subnet_ids = var.subnet_ids # Using your Day 56 VPC Subnets
  }
}

# 2. Create Managed Node Group (Worker Nodes)
resource "aws_eks_node_group" "worker_nodes" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "standard-workers"
  node_role_arn   = var.node_iam_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  update_config {
    max_unavailable = 1
  }
}
