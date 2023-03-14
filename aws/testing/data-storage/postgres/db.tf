resource "aws_security_group" "testing_db" {
  name = "testing-db"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = local.network.private_subnets_cidr_blocks
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
  security_group_names = [aws_security_group.testing_db.name]
  db_subnet_group_name = local.network.database_subnet_group_name
}
