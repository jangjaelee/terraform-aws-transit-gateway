output "tgw_arn" {
  value = aws_ec2_transit_gateway.this.arn
}

output "tgw_id" {
  value = aws_ec2_transit_gateway.this.id
}

output "tgw_tags_all" {
  value = aws_ec2_transit_gateway.this.tags_all
}

output "tgw_owner_id" {
  value = aws_ec2_transit_gateway.this.owner_id
}

output "tgw_association_default_route_table_id" {
  value = aws_ec2_transit_gateway.this.association_default_route_table_id
}

output "tgw_propagation_default_route_table_id" {
  value = aws_ec2_transit_gateway.this.propagation_default_route_table_id
}
