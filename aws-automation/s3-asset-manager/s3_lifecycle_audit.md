# AWS S3 Lifecycle Policy & Retention Audit Runbook
**Author:** Irshadlabs  
**Target Resource:** irshadlabs-mumbai-bucket-2026  

## 1. Objective
To enforce automated data retention boundaries on our S3 bucket. This ensures old logs/assets are purged automatically, preventing data stacking and keeping cloud storage well within the AWS Free Tier (5 GB limit).

## 2. Production Lifecycle Policy JSON Blueprint
To apply this policy via the AWS CLI safely without affecting metadata, the following configuration transitions items to cheaper tiers before expiration:

```json
{
  "Rules": [
    {
      "ID": "PurgeOldServerLogsAfter14Days",
      "Status": "Enabled",
      "Filter": {
        "Prefix": "assets/logs/"
      },
      "Expiration": {
        "Days": 14
      }
    }
  ]
}
