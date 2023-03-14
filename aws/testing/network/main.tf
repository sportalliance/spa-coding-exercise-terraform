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
    vpc_id                      = module.vpc.vpc_id
    private_subnets             = module.vpc.private_subnets
    private_subnets_cidr_blocks = module.vpc.private_subnets_cidr_blocks
    private_route_table_ids     = module.vpc.private_route_table_ids
    database_subnet_group_name  = module.vpc.database_subnet_group_name
  }
}
