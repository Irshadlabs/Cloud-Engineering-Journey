# AWS S3 Cost Optimization & Free Tier Runbook
**Author:** Irshadlabs  
**Target Environment:** Production / Learning Workspace  

## 1. AWS Free Tier Guardrails (Monthly Limits)
To maintain a strict **$0 Monthly Bill**, the architecture must adhere to the following AWS Free Tier limits:
* **Storage:** Max 5 GB of S3 Standard storage.
* **API Requests:** Max 2,000 `PUT/COPY/POST/LIST` requests and 20,000 `GET/SELECT` requests.
* **Data Transfer:** 100 GB of data transfer out to the internet per month.

## 2. Cost Control Best Practices
* **No Crontab Loops:** Do not automate sync scripts on low intervals (e.g., every 5 minutes). Execute manually or once daily to conserve API request limits.
* **Lifecycle Policies:** Configure automatic deletion of logs older than 14 days using S3 Lifecycle Rules to prevent storage stacking.
* **Sync Over Copy:** Always prefer `aws s3 sync` over `aws s3 cp` to ensure only modified files are uploaded, reducing redundant transfer charges.

## 3. Incident Triage for Billing Anomalies
If S3 usage alerts are triggered via CloudWatch:
1. Identify the high-traffic prefix using AWS S3 Storage Lens.
2. Check for rogue loop scripts running on active EC2 instances using `ps aux | grep s3`.

