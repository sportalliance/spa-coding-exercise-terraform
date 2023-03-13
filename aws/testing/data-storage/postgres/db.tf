data "aws_subnet_ids" "main" {
  vpc_id = local.vpc_id
}

data "aws_subnet" "main_subnets" {
  for_each = toset(data.aws_subnet_ids.main.ids)

  id   = each.value
  tags = { type = "private" }
}

locals {
  private_cidrs = [for subnet in data.aws_subnet_ids.main_subnets : subnet.cidr_block]
}

resource "aws_db_subnet_group" "testing" {
  name       = "testing-db"
  subnet_ids = data.aws_subnet_ids.main.ids
}

resource "aws_security_group" "testing_db" {
  name = "testing-db"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = local.private_cidrs
  }
}

resource "aws_db_instance" "testing" {
  identifier_prefix    = "testing-db"
  engine               = "postgresql"
  engine_version       = "15.2"
  instance_class       = "db.t4g.micro"
  allocated_storage    = 50
  name                 = "testing-db"
  username             = "admin"
  password             = "changeme"
  security_group_names = [aws_db_subnet_group.testing.name]
}
