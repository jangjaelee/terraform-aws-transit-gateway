# AWS Transit Gateway Terraform module

Terraform module which creates Transit Gateway resources on AWS.

These types of resources are supported:

* [Transit Gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway)


## Usage
### Create Transit Gateway

`main.tf`
```hcl
module "tgw" {
  source = "git@github.com:jangjaelee/terraform-aws-transit-gateway.git"

  tgw_name         = var.tgw_name
  prefix           = var.prefix
  tags             = var.tags
  description      = var.description
  amazon_side_asn  = var.amazon_side_asn
  enable_dns_support      = var.enable_dns_support
  enable_vpn_ecmp_support = var.enable_vpn_ecmp_support
  enable_default_route_table_association = var.enable_default_route_table_association
  enable_default_route_table_propagation = var.enable_default_route_table_propagation
  enable_auto_accept_shared_attachments  = var.enable_auto_accept_shared_attachments
}
```
---

`provider.tf`
```hcl
provider  "aws" {
  region  =  var.region
  allowed_account_ids = var.account_id
  profile = "default"
}
```
---

`terraform.tf`
```hcl
terraform {
  required_version = ">= 1.1.3"
  
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.72"
    }
  }

  backend "s3" {
    bucket = "kubesphere-terraform-state-backend" # S3 bucket 이름 변경(필요 시)
    key = "kubesphere/tgw/terraform.state"
    region = "ap-northeast-2"
    dynamodb_table = "kubesphere-terraform-state-locks" # 다이나모 테이블 이름 변경(필요 시)
    encrypt = true
    profile = "default"
  }
}
```
---

`variables.tf`
```hcl
variable "region" {
  description = "AWS Region"
  type = string
  default = "ap-northeast-2"
}

variable "account_id" {
  description = "List of Allowed AWS account IDs"
  type = list(string)
}

variable "tgw_name" {
  description = "Name to be used on all the resources as identifier for Transit Gateway"
  type        = string
}

variable "description" {
  description = "Description of the EC2 Transit Gateway"
  type        = string
}

variable "amazon_side_asn" {
  description = "Private Autonomous System Number (ASN) for the Amazon side of a BGP session. The range is 64512 to 65534"
  type        = number
}

variable "prefix" {
  description = "prefix for aws resources and tags"
  type = string
}

variable "tags" {
  description = "tag map"
  type = map(string)
}

variable "enable_dns_support" {
  description = "Whether DNS support is enabled"
  type        = bool
  default     = true
}

variable "enable_vpn_ecmp_support" {
  description = "Whether VPN Equal Cost Multipath Protocol support is enabled"
  type        = bool
  default     = true
}

variable "enable_default_route_table_association" {
  description = "Whther resource attachments are automatically associated with the default association route table"
  type        = bool
  default     = true
}

variable "enable_default_route_table_propagation" {
  description = "Whether resource attachments automatically propagate routes to the default propagation route table"
  type        = bool
  default     = true
}

variable "enable_auto_accept_shared_attachments" {
  description = "Whether resource attachment requests are automatically accepted"
  type        = bool
  default     = true
}
```
---

`terraform.tfvars`
```hcl
region      = "ap-northeast-2"
account_id  = ["123456789012"]
prefix      = "dev"
tgw_name    = "common"
description = "Main Transit Gateway"
amazon_side_asn                        = "64512"
enable_dns_support                     = true
enable_vpn_ecmp_support                = true
enable_default_route_table_association = false
enable_default_route_table_propagation = false
enable_auto_accept_shared_attachments  = false

tags = {
    "CreatedByTerraform" = "true"
    "TerraformModuleName" = "terraform-aws-module-transit-gateway"
    "TeffaformModuleVersion" = "v1.0.0"
}
```
---

`outputs.tf`
```hcl
output "tgw_arn" {
  value = module.tgw.tgw_arn
}

output "tgw_id" {
  value = module.tgw.tgw_id
}

output "tgw_tags_all" {
  value = module.tgw.tgw_tags_all
}

output "tgw_owner_id" {
  value = module.tgw.tgw_owner_id
}

output "tgw_association_default_route_table_id" {
  value = module.tgw.tgw_association_default_route_table_id
}

output "tgw_propagation_default_route_table_id" {
  value = module.tgw.tgw_propagation_default_route_table_id
}
```
