# AWS Infrastructure Monorepo (Terragrunt)

![Terraform](https://img.shields.io/badge/Terraform-1.5+-623CE4?style=flat&logo=terraform)
![Terragrunt](https://img.shields.io/badge/Terragrunt-0.50+-00B39F?style=flat)
![AWS](https://img.shields.io/badge/Provider-AWS-232F3E?style=flat&logo=amazon-aws)

This repository contains the Infrastructure as Code (IaC) definitions for provisioning a highly available, multi-region, and multi-environment AWS cloud architecture.

By leveraging **Terragrunt** on top of **Terraform**, this project strictly follows the **DRY (Don't Repeat Yourself)** principle, cleanly separating the infrastructure logic (modules) from environment-specific configurations (live state).

## 🏗 Architecture & Design Patterns

*   **DRY Configurations:** Uses `terragrunt.hcl` `include` blocks to inherit remote state configuration (S3 backend + DynamoDB locking) and provider definitions dynamically across all environments.
*   **Module Isolation:** Base infrastructure logic (`vpc`, `ec2`, `rds`, `s3`) is abstracted into reusable Terraform modules.
*   **Multi-Environment:** Strict separation of `dev` and `prod` state, preventing accidental cross-environment modifications.
*   **Multi-Region:** Supports dynamic region deployments (`eu-west-1`, `us-east-1`) using inherited `region.hcl` variables.
*   **Dependency Management:** Uses Terragrunt `dependency` blocks with `mock_outputs` to safely orchestrate module creation order (e.g., VPC -> Security Groups -> EC2/RDS) without failing `plan` validations.

## 📂 Repository Structure

The monorepo is split into two main layers:

```text
.
├── modules/                # 📦 Reusable, stateless Terraform modules
│   ├── ec2/
│   ├── rds/
│   ├── security_group/
│   └── vpc/
│
└── environments/           # 🌍 Live state and environment variables
    ├── eu-west-1/          
    │   ├── dev/            # Dev Environment (t2.micro instances)
    │   └── prod/           # Prod Environment (t2.large, HA Database)
    └── us-east-1/          
        └── dev/
```

## 🚀 Usage

To plan or apply changes to a specific environment (e.g., EU Dev EC2):

```bash
cd environments/eu-west-1/dev/ec2

# Check formatting and evaluate variables
terragrunt plan

# Provision the infrastructure
terragrunt apply
```

To deploy an entire environment (all modules) sequentially based on their dependencies:

```bash
cd environments/eu-west-1/dev
terragrunt run-all apply
```