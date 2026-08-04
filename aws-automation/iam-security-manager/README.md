# AWS IAM Security & Compliance Audit Manager

Automated Bash-based security audit tools for AWS Identity and Access Management (IAM). Designed to audit user security posture, enforce credential rotation policies, and identify security risks—operating strictly within zero-cost read-only IAM calls.

## Features

* **MFA Compliance Audit (`iam_mfa_audit.sh`)**: Scans all IAM users across the AWS account to verify active Multi-Factor Authentication (MFA) devices.
* **Access Key Age Audit (`iam_access_key_audit.sh`)**: Evaluates Access Key creation timestamps and flags active credentials older than 90 days.
* **Zero-Cost & Secure**: Executes read-only AWS CLI queries adhering to strict Least Privilege policies without incurring billable API overhead.

## Requirements & Usage

Ensure AWS CLI is configured with appropriate read privileges (`iam:ListUsers`, `iam:ListMFADevices`, `iam:ListAccessKeys`).
