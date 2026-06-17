# -----------------------------------------------------------------------------------
# Resource: dynamic_instance_tagging
# Purpose: Implements environment-based naming convention using Terraform Workspaces.
# -----------------------------------------------------------------------------------

locals {
  # Define instance types based on the active workspace
  # This avoids hardcoding and mimics real production workflows
  instance_type_map = {
    default = "t2.micro"
    dev     = "t2.micro"
    prod    = "t3.small"
  }

  project_name = "irshadlabs-cloud-platform"
}

resource "aws_instance" "app_server" {
  # Lookup instance type based on terraform.workspace (dev, prod, etc.)
  instance_type = lookup(local.instance_type_map, terraform.workspace, "t2.micro")
  ami           = "ami-0c55b159cbfafe1f0"

  tags = {
    Name        = "${local.project_name}-${terraform.workspace}-server"
    Environment = terraform.workspace
    ManagedBy   = "terraform"
  }
}

# Output to verify current deployment context
output "active_environment_info" {
  description = "Displays the current workspace and associated instance type"
  value       = "Deploying to [${terraform.workspace}] using [${local.instance_type_map[terraform.workspace]}]"
}
