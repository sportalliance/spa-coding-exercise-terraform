terraform {
  backend "s3" {
    bucket         = "org.exmaple.com.coding-exercise"
    key            = "data-storage/postgres"
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

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "org.exmaple.com.coding-exercise"
    key    = "network"
    region = "eu-central-1"
  }
}

locals {
  network = {
    vpc_id                      = data.terraform_remote_state.network.outputs.exports.vpc_id
    database_subnet_group_name  = data.terraform_remote_state.network.outputs.exports.database_subnet_group_name
    private_subnets_cidr_blocks = data.terraform_remote_state.network.outputs.exports.private_subnets_cidr_blocks
  }
}
