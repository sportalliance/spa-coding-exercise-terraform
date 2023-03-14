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
    vpc_id = "arn:partition:service:region:account-id:vpc-id"
    privat_subnet_route_tables = toset([
      "arn:partition:service:region:account-id:rt-1",
      "arn:partition:service:region:account-id:rt-2",
      "arn:partition:service:region:account-id:rt-3"
    ])
  }
}
