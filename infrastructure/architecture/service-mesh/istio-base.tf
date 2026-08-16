# -----------------------------------------------------------------------------------
# Resource: helm_release (Istio Base)
# Description: Deploys the Istio Service Mesh base components to the EKS cluster.
#              This enables advanced traffic management, security (mTLS), and 
#              observability between microservices.
# Author: Mohammed Irshad (AWS Solutions Architect)
# -----------------------------------------------------------------------------------

# 1. Create a dedicated namespace for Istio
resource "kubernetes_namespace" "istio_system" {
  metadata {
    name = "istio-system"
  }
}

# 2. Deploy Istio Base (CRDs and essential components)
resource "helm_release" "istio_base" {
  name       = "istio-base"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "base"
  namespace  = "istio-system"

  set {
    name  = "global.jwtPolicy"
    value = "third-party-jwt"
  }
}

# 3. Deploy Istio Discovery (Istiod) - The Control Plane
resource "helm_release" "istiod" {
  name       = "istiod"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart      = "istiod"
  namespace  = "istio-system"
  depends_on = [helm_release:istio_base]

  set {
    name  = "meshConfig.accessLogFile"
    value = "/dev/stdout"
  }
}
