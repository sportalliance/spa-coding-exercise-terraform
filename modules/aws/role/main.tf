/*
* # IAM Role Module
*
* Module to create an assumable IAM role.
*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.58"
    }
  }
}

resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = var.assume_policy_json
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = var.policy_arns

  role       = aws_iam_role.this.name
  policy_arn = eack.key
}
