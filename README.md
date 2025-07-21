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


