resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = { Name = "${var.resource_name}-private" }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = { Name = "${var.resource_name}-public" }
}

resource "aws_route" "all_traffic_igw_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
