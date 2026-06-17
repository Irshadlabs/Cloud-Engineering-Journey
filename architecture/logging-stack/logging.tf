# -----------------------------------------------------------------------------------
# Resource: aws_cloudwatch_log_group
# Description: Establishes a centralized logging hub for EKS pods using 
#              CloudWatch Container Insights for deep log analysis and searching.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

# 1. Create a Log Group for the Cluster
resource "aws_cloudwatch_log_group" "eks_logs" {
  name              = "/aws/eks/irshadlabs-eks-cluster/logs"
  retention_in_days = 30 # Security/Cost: Auto-delete logs after 30 days

  tags = {
    Environment = "Production"
    Application = "Container-Insights"
  }
}

# 2. IAM Policy to allow EKS Nodes to send logs to CloudWatch
resource "aws_iam_role_policy_attachment" "cloudwatch_agent_policy" {
  role       = var.node_iam_role_name # Your Day 72 Node Role
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# 3. CloudWatch Metric Stream (Optional for Real-time Dashboards)
resource "aws_cloudwatch_metric_stream" "main" {
  name          = "eks-performance-stream"
  role_arn      = aws_iam_role.metric_stream_role.arn
  firehose_arn  = aws_kinesis_firehose_delivery_stream.s3_stream.arn
  output_format = "json"
}
