terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-northeast-1"
}

module "ecr" {
  source = "./modules/ecr"

  repository_name = "test-repository"
  tags = {
    Environment = "production"
    Terraform   = "true"
  }
}