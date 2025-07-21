# ELEVATED-SESSION-FINAL-1

This is a modular and environment-based Terraform project designed to provision and manage AWS infrastructure. It follows a reusable module structure and separates environments using individual `tfvars` files.

---

## 📁 Project Structure

elevated-session-final-1/
├── envs/
│ ├── dev/
│ │ ├── backend.tf
│ │ ├── iam_ec2_secrets.tf
│ │ ├── main.tf
│ │ ├── outputs.tf
│ │ ├── secrets_manager.tf
│ │ ├── terraform.tfvars
│ │ ├── user3terraform.tfvars
│ │ └── variables.tf
│ └── prod/
│ └── ...
│
├── modules/
│ ├── ec2/
│ │ ├── main.tf
│ │ ├── outputs.tf
│ │ ├── variables.tf
│ │ ├── script/
│ │ └── typescript/
│ ├── rds/
│ │ ├── main.tf
│ │ ├── outputs.tf
│ │ └── variables.tf
│ ├── s3_cdn/
│ │ └── ...
│ └── security-group-rds/
│ ├── main.tf
│ ├── outputs.tf  
│ └── variables.tf


---

## 🚀 Getting Started

### 1. Initialize Terraform
```bash
terraform init

2. Plan Infrastructure
bash
Copy
Edit
terraform plan -var-file="envs/dev/terraform.tfvars"

3. Apply Infrastructure
bash
Copy
Edit
terraform apply -var-file="envs/dev/terraform.tfvars"


🔐 Secrets Management
Secrets (like IAM credentials, DB passwords) are managed using:

secrets_manager.tf for integration with AWS Secrets Manager

iam_ec2_secrets.tf to grant EC2 permission to access secrets

Note: Avoid hardcoding secrets in .tf or .tfvars files.


Modules Overview
ec2/ – Launch EC2 instances and assign IAM roles

rds/ – Provision RDS databases with security groups

s3_cdn/ – S3 bucket for CDN storage (CloudFront-ready)

security-group-rds/ – Custom security group for database access

Environments
envs/dev/ — Terraform config and variables for development

envs/prod/ — (To be configured for production setup)

Best Practices
Use terraform fmt to format all files

Use terraform validate before apply

Organize environments using separate folders

Use version control to manage your infrastructure changes

Requirements
Terraform CLI

AWS CLI configured with credentials (~/.aws/credentials)

Git (for version control)

Author
Kamlesh Thakur
GitHub: @THAKURkamlesh


Add full project README with structure, usage, and modules

