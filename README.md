# Reusable AWS IaC Terraform Modules

A collection of security-hardened, reusable, and composable Terraform modules to automate cloud provisioning on Amazon Web Services (AWS).

## 📦 Directory Structure

```
.
├── modules/
│   ├── vpc/             # Provision VPC, subnets, route tables, Gateways
│   ├── asg/             # Deploy auto-scaling groups with Launch Templates
│   └── s3/              # Secure S3 buckets with encryption and blocking public access
├── examples/
│   └── complete/        # An integration template orchestrating the three modules
├── .gitignore           # File exclusions
└── README.md            # Modules documentation
```

## ⚙️ How to Import Modules

Reference these modules directly in your root Terraform configuration:

### VPC module:
```hcl
module "my_vpc" {
  source   = "git::https://github.com/Pradeeptalari14/terraform-aws-modules.git//modules/vpc?ref=main"
  vpc_name = "production-vpc"
  vpc_cidr = "10.0.0.0/16"

  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
  azs                  = ["us-east-1a", "us-east-1b"]
}
```

### S3 bucket module:
```hcl
module "secure_bucket" {
  source      = "git::https://github.com/Pradeeptalari14/terraform-aws-modules.git//modules/s3?ref=main"
  bucket_name = "sutter-health-records-storage"
}
```

## 📜 License

This project is licensed under the MIT License.
