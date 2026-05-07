# -----------------------------------------------------------------------------------
# Resource: aws_grafana_workspace
# Description: Deploys a managed Grafana instance to visualize metrics and 
#              logs. It acts as the centralized dashboard for the EKS cluster.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

resource "aws_grafana_workspace" "main" {
  name                     = "irshadlabs-ops-dashboard"
  account_access_type      = "CURRENT_ACCOUNT"
  authentication_providers = ["AWS_SSO"] # Enterprise standard for secure access
  permission_type          = "SERVICE_MANAGED"
  data_sources             = ["PROMETHEUS"] # Connecting to Day 82's Prometheus

  # Defining the organizational role for the engineer
  role_arn = aws_iam_role.grafana_admin.arn

  tags = {
    Name = "central-monitoring-hub"
    Role = "Observability"
  }
}

# Output the URL where the dashboard will be live
output "grafana_url" {
  value = aws_grafana_workspace.main.endpoint
}
