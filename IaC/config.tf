terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  # S3 bucket details as backend to store terraform state file.
  backend "s3" {
    bucket = "anurag-servian-bucket-1"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}