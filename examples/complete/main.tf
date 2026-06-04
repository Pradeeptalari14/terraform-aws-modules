# Complete Integration Example using Local Modules
provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source   = "../../modules/vpc"
  vpc_name = "sutter-health-prod-vpc"
  vpc_cidr = "10.10.0.0/16"

  public_subnet_cidrs  = ["10.10.1.0/24", "10.10.2.0/24"]
  private_subnet_cidrs = ["10.10.10.0/24", "10.10.11.0/24"]
  azs                  = ["us-east-1a", "us-east-1b"]
}

module "s3_artifacts" {
  source      = "../../modules/s3"
  bucket_name = "sutter-health-pipeline-artifacts-bucket"
}

module "compute_group" {
  source      = "../../modules/asg"
  name_prefix = "production-app-node"
  ami_id      = "ami-0c7217cdde317cfec" # Amazon Linux 2 AMI
  subnet_ids  = module.vpc.private_subnet_ids

  security_groups  = ["sg-09ab87c6d5e4f3a2"]
  min_size         = 2
  max_size         = 6
  desired_capacity = 2
}
