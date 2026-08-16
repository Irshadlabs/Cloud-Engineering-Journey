# AWS S3 Public Access Block & Security Audit Runbook
**Author:** Irshadlabs  
**Target Resource:** irshadlabs-mumbai-bucket-2026  

## 1. Objective
To audit and verify that "Block Public Access" is strictly enabled on our S3 infrastructure. Preventing accidental public exposure is the highest priority security control for cloud data storage.

## 2. Security Audit Commands
To verify that the bucket is completely sealed from the public internet without generating data transfer costs:

* **Check Public Access Block Status:**
  ```bash
  aws s3api get-public-access-block --bucket irshadlabs-mumbai-bucket-2026
