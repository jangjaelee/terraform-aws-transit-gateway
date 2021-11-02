resource "aws_ec2_transit_gateway" "this" {
  description      = var.description
  amazon_side_asn  = var.amazon_side_asn
  dns_support      = var.enable_dns_support ? "enable" : "disable"
  vpn_ecmp_support = var.enable_vpn_ecmp_support ? "enable" : "disable"
  
  default_route_table_association = var.enable_default_route_table_association ? "enable" : "disable"
  default_route_table_propagation = var.enable_default_route_table_propagation ? "enable" : "disable"
  auto_accept_shared_attachments  = var.enable_auto_accept_shared_attachments ? "enable" : "disable"

  tags = merge(
    {
      "Name" = format("%s-tgw", var.tgw_name)
    },
    local.common_tags,
  )
}
