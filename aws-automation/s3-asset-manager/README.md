# AWS S3 Asset Manager & Security Audit Toolkit

This repository module contains automated scripts, governance compliance tools, and operational runbooks engineered for AWS S3 bucket management. The entire toolkit is architected to operate strictly within the **AWS Free Tier ($0 Budget Guardrails)** while enforcing enterprise-grade security structures.

---

## Module Architecture & Components

### 1. Security & Compliance Automation (Auditing Suite)
These programmatic shell scripts interface directly with the AWS Metadata API to audit and report on bucket security postures without generating data-transfer costs:
* `s3_encryption_audit.sh` - Validates server-side default encryption state (AES256 compliance).
* `s3_logging_audit.sh` - Audits Server Access Logging status to maintain comprehensive data access trails.
* `s3_versioning_audit.sh` - Verifies object versioning state for point-in-time data recovery and ransomware mitigation.
* `s3_ownership_audit.sh` - Validates object ownership configurations to enforce BucketOwnerEnforced policies and disable legacy ACLs.
* `s3_cors_audit.sh` - Diagnostics tool to audit Cross-Origin Resource Sharing (CORS) rules against unauthorized domain queries.

### 2. Operational Runbooks & Governance Manuals
Standard operating procedures (SOPs) designed to streamline cloud administration and audit compliance:
* `s3_cost_optimization.md` - Detailed manual defining AWS API request thresholds and optimization guidelines to guarantee a $0 monthly footprint.
* `s3_lifecycle_audit.md` - JSON blueprints and implementation steps for automated data retention and lifecycle transitions.
* `s3_public_access_audit.md` - Incident remediation manual for managing and auditing S3 Block Public Access configurations.

### 3. Deployment Automation
* `deploy_assets.sh` - An optimized deployment script utilizing aws s3 sync instead of standard copy operations, minimizing redundant API requests and maximizing transaction efficiency.

---

## Enterprise Security Guardrails

> 🔒 **IAM Role-Based Authentication Policy:** This toolkit strictly adheres to a zero-hardcoded-credentials policy. Authentication relies entirely on dynamic IAM Roles attached to the host EC2 instance. No AWS Access Keys, Secret Access Keys, or permanent security tokens are stored within this codebase, ensuring zero risk of credential exposure.

---
**Maintained by:** Irshadlabs | **Deployment Environment:** AWS Production Support
