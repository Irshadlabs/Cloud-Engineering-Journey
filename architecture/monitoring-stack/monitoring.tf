# -----------------------------------------------------------------------------------
# Resource: AWS Managed Service for Prometheus (AMP)
# Description: Provisions a scalable, secure monitoring workspace to collect 
#              metrics from EKS clusters without managing the underlying storage.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

# 1. Create a Prometheus Workspace
resource "aws_prometheus_workspace" "eks_monitor" {
  alias = "irshadlabs-production-metrics"

  tags = {
    Environment = "Production"
    Project     = "Observability-2026"
  }
}

# 2. Create an IAM Role for Service Accounts (IRSA)
# This allows Prometheus inside EKS to securely send data to AWS
resource "aws_iam_role" "prometheus_ingest" {
  name = "eks-prometheus-ingest-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Effect = "Allow"
      Principal = {
        Federated = var.oidc_provider_arn
      }
    }]
  })
}

# 3. Output the Workspace Endpoint
output "prometheus_endpoint" {
  value = aws_prometheus_workspace.eks_monitor.prometheus_endpoint
}
