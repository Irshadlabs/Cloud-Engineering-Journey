
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
## 🏛️ Enterprise AWS 3-Tier Architecture

Below is the production-grade, highly available, and fault-tolerant 3-tier architecture deployed across multiple Availability Zones (AZs) inside a custom Virtual Private Cloud (VPC).

```mermaid
flowchart TD
    subgraph Internet ["🌐 Public Internet"]
        Users["Client / Users"]
        Route53["AWS Route 53 (DNS)"]
        Users --> Route53
    end

    subgraph AWS_Cloud ["☁️ AWS Cloud - Region"]
        WAF["AWS WAF (Web Application Firewall)"]
        Route53 --> WAF

        subgraph VPC ["🔒 Production VPC (10.0.0.0/16)"]
            
            subgraph Public_Subnets ["Public Subnets (DMZ)"]
                ALB["Application Load Balancer (ALB)"]
                NAT_GW["NAT Gateway (Outbound Internet)"]
            end
            WAF --> ALB

            subgraph App_Subnets ["App Tier - Private Subnets (Multi-AZ)"]
                subgraph AZ_A ["AZ-a"]
                    EC2_A["App Server (EC2 Auto Scaling)"]
                end
                subgraph AZ_B ["AZ-b"]
                    EC2_B["App Server (EC2 Auto Scaling)"]
                end
            end
            ALB --> EC2_A
            ALB --> EC2_B
            EC2_A -.-> NAT_GW
            EC2_B -.-> NAT_GW

            subgraph DB_Subnets ["Data Tier - Isolated Private Subnets"]
                RDS_Primary[("Amazon RDS (Primary Writer)")]
                RDS_Standby[("Amazon RDS (Standby Replica)")]
                RDS_Primary -. Synchronous Sync .-> RDS_Standby
            end
            EC2_A --> RDS_Primary
            EC2_B --> RDS_Primary

        end
    end

    classDef primary fill:#e3f2fd,stroke:#1565c0,stroke-width:2px;
    classDef subnets fill:#f1f8e9,stroke:#558b2f,stroke-width:1px;
    class ALB,RDS_Primary primary;
