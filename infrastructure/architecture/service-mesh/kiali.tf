# -----------------------------------------------------------------------------------
# Resource: helm_release (Kiali Server)
# Description: Deploys Kiali to visualize the Istio Service Mesh. It provides 
#              a real-time graph of microservices communication and security status.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

# 1. Deploy Kiali Server via Helm
resource "helm_release" "kiali_server" {
  name       = "kiali-server"
  repository = "https://kiali.org/helm-charts"
  chart      = "kiali-server"
  namespace  = "istio-system" # Keeping it in the same namespace as Istio

  set {
    name  = "auth.strategy"
    value = "anonymous" # For lab/testing. Use 'openid' for production.
  }

  set {
    name  = "external_services.prometheus.url"
    value = "http://prometheus-server.monitoring-stack:80" # Connecting to Day 82's Prometheus
  }
}

# 2. Output the Kiali access command
output "kiali_dashboard_hint" {
  value = "Run 'istioctl dashboard kiali' to open the traffic map."
}
