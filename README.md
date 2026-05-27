[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badgelogo=amazon-awslogoColor=white)](https://aws.amazon.com/) [![Terraform](https://img.shields.io/badge/terraform-%23623CE4.svg?style=for-the-badgelogo=terraformlogoColor=white)](https://www.terraform.io/) [![Kubernetes](https://img.shields.io/badge/kubernetes-%23326CE5.svg?style=for-the-badgelogo=kuberneteslogoColor=white)](https://kubernetes.io/) [![Istio](https://img.shields.io/badge/Istio-%23466BB0.svg?style=for-the-badgelogo=IstiologoColor=white)](https://istio.io/)

![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
   ![Terraform](https://img.shields.io/badge/terraform-%235C4EE5.svg?style=for-the-badge&logo=terraform&logoColor=white)
   ![Kubernetes](https://img.shields.io/badge/kubernetes-%23326CE5.svg?style=for-the-badge&logo=kubernetes&logoColor=white)
   ![GitHub Actions](https://img.shields.io/badge/github%20actions-%232088FF.svg?style=for-the-badge&logo=github-actions&logoColor=white)
   ![Security Policy](https://img.shields.io/badge/Security-Enforced-success?style=for-the-badge)

  

# ☁️ Cloud & Network Engineering Portfolio
**Author: Mohammed Irshad** *AWS Certified Solutions Architect | CCNA | MCP | B.Tech (CS)*

Welcome to my DevOps & Cloud automation journey. This repository contains production-ready scripts for managing cloud infrastructure and network security.

---

### 🎓 Professional Certifications
- 🏆 **AWS Certified Solutions Architect**
- 🌐 **Cisco Certified Network Associate (CCNA)**
- 💻 **Microsoft Certified Professional (MCP)**

---

### 📂 Project Structure (Categorized)

| Folder | Description | Key Scripts |
| :--- | :--- | :--- |
| **[Monitoring](./monitoring)** | System health & Service audits | `healthcheck.sh`, `multi_services_check.sh` |
| **[Security](./security)** | Network scanning & Cloud readiness | `Port_scan.sh`, `cloud_ready.sh` |
| **[Automation](./automation)** | Automated backups & Maintenance | `backup.sh`, `system_cleanup.sh` |
| **[User-Mgmt](./user-management)** | Bulk User onboarding/offboarding | `create_user.sh`, `delete_user.sh` |


### 🚀 How to Run
1. Clone: `git clone https://github.com/Irshadlabs/Cloud-Engineering-Journey.git`
2. Permissions: `chmod +x */*.sh`
3. Execute: `./monitoring/healthcheck.sh`


**Environment:** Ubuntu 22.04 LTS on AWS EC2


> ⚠️ **Production Note:** Never deploy live workloads to the `default` namespace. Always isolate components using dedicated microservices namespaces with network policies enforced.

## 🔒 Cloud Network Security Matrix (Security Groups vs NACLs)

To enforce strict boundary control within my multi-VPC and EKS topologies, I architect network isolation based on this functional state model:

| Feature | Security Groups (Instance Level) | Network ACLs (Subnet Level) |
| :--- | :--- | :--- |
| **Type** | Stateful (Return traffic is automatically allowed) | Stateless (Return traffic must be explicitly defined) |
| **Scope** | Evaluated at the EC2 Instance / Elastic Network Interface (ENI) | Evaluated at the Subnet boundary |
| **Rules Support** | Supports `Allow` rules only (Default deny all traffic) | Supports both `Allow` and `Deny` rules |
| **Evaluation** | All rules are evaluated simultaneously before traffic passes | Rules are processed sequentially in numbered order |

> 💡 **Design Pattern:** In my architecture, NACLs are utilized as a coarse-grained firewall block (e.g., blocking malicious IP CIDRs at the subnet gate), while Security Groups handle the fine-grained application-level access controls.
