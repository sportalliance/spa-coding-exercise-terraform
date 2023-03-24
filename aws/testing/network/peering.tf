locals {
  other_account_account_id           = "arn:partition:service:region:account-id:other-account"
  other_account_vpc_id               = "arn:partition:service:region:account-id:other-account-vpc-id"
  other_account_private_subnet_cidrs = toset(["10.1.0.0/24", "10.1.1.0/24", "10.1.2.0/24"])
  route_table_x_cidrs = toset(flatten([
    [for route_table_id in module.vpc.private_route_table_ids : [
      for cidr in local.other_account_private_subnet_cidrs : {
        route_table_id = route_table_id,
        cidr           = cidr
      }
    ]]
  ]))
}

resource "aws_route" "private_subnet_to_other_account" {
  for_each = local.route_table_x_cidrs

  route_table_id            = each.value.route_table_id
  destination_cidr_block    = each.value.cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.other_account.id
}

resource "aws_vpc_peering_connection_options" "other_account" {
  vpc_peering_connection_id = aws_vpc_peering_connection.other_account.id

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_vpc_peering_connection" "other_account" {
  peer_owner_id = local.other_account_account_id
  peer_vpc_id   = local.other_account_vpc_id
  vpc_id        = module.vpc.vpc_id
  auto_accept   = true

  tags = {
    Name = "VPC Peering between testing and other-account"
  }
}
