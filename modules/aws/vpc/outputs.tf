output "vpc_arn" {
  description = "ARN of the VPC"
  value       = aws_vpc.vpc.arn
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc.id
}
