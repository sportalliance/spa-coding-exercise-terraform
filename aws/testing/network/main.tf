terraform {
  backend "s3" {
    bucket         = "org.exmaple.com.coding-exercise"
    key            = "network"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.58" # see https://developer.hashicorp.com/terraform/language/expressions/version-constraints
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

output "exports" {
  value = {
    vpc_id = "arn:partition:service:region:account-id:resource-id"
  }
}
