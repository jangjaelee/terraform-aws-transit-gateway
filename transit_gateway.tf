resource "null_resource" "validate_module_name" {
  count = local.module_name == var.tags["TerraformModuleName"] ? 0 : "Please check that you are using the Terraform module"
}

resource "null_resource" "validate_module_version" {
  count = local.module_version == var.tags["TerraformModuleVersion"] ? 0 : "Please check that you are using the Terraform module"
}

resource "aws_ec2_transit_gateway" "this" {
  description      = var.description
  amazon_side_asn  = var.amazon_side_asn
  dns_support      = var.enable_dns_support ? "enable" : "disable"
  vpn_ecmp_support = var.enable_vpn_ecmp_support ? "enable" : "disable"
  
  default_route_table_association = var.enable_default_route_table_association ? "enable" : "disable"
  default_route_table_propagation = var.enable_default_route_table_propagation ? "enable" : "disable"
  auto_accept_shared_attachments  = var.enable_auto_accept_shared_attachments ? "enable" : "disable"

  tags = merge(
    var.tags, tomap(
      {"Name" = format("%s-%s-tgw", var.prefix, var.tgw_name)}
    )
  )  
}