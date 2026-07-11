
# Cloud Engineering Journey

This repository tracks my advanced hands-on deployments and architecture templates for scalable, secure, and cost-optimized cloud infrastructure. It acts as an operational sandbox mapping multi-region network topologies, container orchestration, centralized observability, and active cost-management pipelines on AWS using Terraform.

---

## 📂 Infrastructure Components & Architecture

### 1. Advanced Networking & Edge Traffic Management
*   **Transit Gateway (`/transit-gateway`):** Implementation of a centralized AWS Transit Gateway (TGW) to aggregate and scale multi-VPC cross-environment routing without relying on full-mesh peering.
*   **VPC Peering (`/vpc-peering`):** Automated peer-connections for strict, isolated data path communication between staging and production environments.
*   **Global Accelerator (`/global-accelerator`):** Anycast IP routing setup via AWS Global Accelerator to minimize latency and optimize ingress traffic paths for global endpoints.
*   **CDN Distribution (`/cdn-distribution`):** Automated CloudFront CDN configurations tailored for caching, SSL terminations, and fast static content delivery.
*   **DNS Management (`/dns-management`):** Automated Route 53 record sets dynamically mapped to Application Load Balancers (ALB).

### 2. Kubernetes Orchestration & Zero-Trust Security
*   **EKS Cluster (`/eks-cluster`):** Scalable AWS EKS configuration running automated path-based Application Load Balancer (ALB) Ingress Controllers to manage traffic routing across multiple microservices.
*   **Service Mesh (`/service-mesh`):** Implementation of service mesh frameworks enforcing strict mutual TLS (mTLS) compliance to establish a zero-trust network topology between container communications.

### 3. Production Observability & Centralized Logs
*   **Logging Stack (`/logging-stack`):** Deployment of structured CloudWatch logging agents across infrastructure blocks to achieve single-pane log visibility.
*   **Monitoring Stack (`/monitoring-stack`):** Infrastructure monitoring using Prometheus for high-frequency resource metrics, coupled with automated SNS channels to trigger immediate operational alerts.

### 4. Enterprise FinOps & Governance
*   **Cost Management (`/cost-management`):** Proactive budget monitoring with automated threshold alerts configured via Terraform to prevent unexpected cloud expenditure spikes.

---

## 🗺️ Architectural Diagrams
The repository features baseline multi-tier network and system topology layouts:
*   `AWS VPC.drawio.png` – Comprehensive documentation of underlying AWS networking components.

---

## 🛠️ Tooling & Infrastructure Stack
*   **Cloud Provider:** Amazon Web Services (AWS)
*   **Infrastructure as Code (IaC):** Terraform (Modularized Architecture)
*   **Orchestration:** Kubernetes (EKS), Service Mesh (Istio/AWS App Mesh)
*   **Observability:** Prometheus, AWS CloudWatch, SNS Alerts

---

## 🚀 Deployment Discipline
Every architecture module in this workspace is deployed via custom Terraform runs inside an AWS sandboxed environment. Continuous iteration focuses on security hardening (mTLS/Transit Gateway separation) and high availability while strictly monitoring Free Tier boundaries.
