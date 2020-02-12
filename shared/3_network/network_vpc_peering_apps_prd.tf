#
# VPC Peering Connection with Apps Prd: Accepter Side
#
resource "aws_vpc_peering_connection_accepter" "with_apps_prd" {
  count = var.vpc_apps_prd_created == true ? 1 : 0

  vpc_peering_connection_id = data.terraform_remote_state.vpc-apps-prd.outputs.vpc_peering_id_apps_prd_with_shared
  auto_accept               = true

  tags = merge(map("Name", "accepter-shared-from-apps-prd"), local.tags)
}

#
# Update Route Tables to go through the VPC Peering Connection
#
resource "aws_route" "priv_route_table_1_to_prd_vpc" {
  count = var.vpc_apps_prd_created == true ? 1 : 0

  route_table_id            = element(module.vpc.private_route_table_ids, 0)
  destination_cidr_block    = data.terraform_remote_state.vpc-apps-prd.outputs.vpc_cidr_block
  vpc_peering_connection_id = data.terraform_remote_state.vpc-apps-prd.outputs.vpc_peering_id_apps_prd_with_shared
}

resource "aws_route" "pub_route_table_1_to_apps_prd_vpc" {
  count = var.vpc_apps_prd_created == true ? 1 : 0

  route_table_id            = element(module.vpc.public_route_table_ids, 0)
  destination_cidr_block    = data.terraform_remote_state.vpc-apps-prd.outputs.vpc_cidr_block
  vpc_peering_connection_id = data.terraform_remote_state.vpc-apps-prd.outputs.vpc_peering_id_apps_prd_with_shared
}