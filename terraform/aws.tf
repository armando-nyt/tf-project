# general  configuration for AWS provider
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = data.local_file.account_key.content
  secret_key = data.local_file.account_secret.content
}
