# Security Policy

## Supported Versions
Right now, I am only maintaining and providing security updates for the **main** branch. I recommend always staying up to date with this branch for the latest fixes.

## Reporting a Vulnerability
If you spot any security vulnerability or a bug in this project, **please do not open a public issue.** 

To keep the project safe, it’s better to report it privately. You can use the **GitHub "Security" tab** to submit a report or reach out to me directly. I’ll try my best to look into it as soon as possible.

### My Security Commitment:
*   **Zero Plain-Text Secrets:** I don’t keep any passwords, API keys, or credentials in my HCL/Terraform files. All sensitive data is managed via **AWS Secrets Manager**.
*   **Secure State Management:** My Terraform state is never stored locally. It’s kept in an **S3 bucket** with encryption and versioning turned on.
*   **No Accidental Leaks:** I use a strict `.gitignore` policy to make sure no `.tfvars` or local environment files ever reach the public repository.
