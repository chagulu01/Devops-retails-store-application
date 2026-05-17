# Terraform block
terraform {
  required_version = ">=1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    /* random = {
      source = "hashicorp/random"
      version = "~> 3.0"
    }
   */
  }
  backend "s3" {
    bucket  = "dev-bucket-predev-us-east-1-1n30t5"
    key     = "dev/vpc/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

# Provider block
provider "aws" {
  region = "us-east-1"
}


