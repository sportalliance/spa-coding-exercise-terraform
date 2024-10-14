variable "resource_name" {
  description = "Name used for all resources of this module"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr_block" {
  description = "CIDR block to use for the public subnet per availability zone"
  type        = string
}

variable "private_subnet_cidr_block" {
  description = "CIDR block to use for the private subnet per availability zone"
  type        = string
}

variable "availability_zone" {
  description = "AZ for public and private subnet"
  type        = string
}
