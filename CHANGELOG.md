# Changelog

All notable changes to this Cloud & DevOps project will be documented in this file.

## [1.2.0] - 2026-05-16
### Added
- Created `SECURITY.md` to define private vulnerability reporting and security commitment.
- Optimized `.gitignore` to prevent accidental leaks of `.tfvars` and local state files.

## [1.1.0] - 2026-05-12
### Added
- Implemented **Istio Service Mesh** for zero-trust network security.
- Enforced **STRICT mTLS** across application namespaces.
- Added **Kiali** dashboard for real-time service traffic visualization.

## [1.0.0] - 2026-05-10
### Added
- Completed core infrastructure deployment using **Terraform** (VPC, Transit Gateway, EKS Cluster).
- Set up automated CI/CD pipelines via **GitHub Actions** for linting and deployment.
- Integrated **Prometheus & Grafana** for full-stack cluster observability.
