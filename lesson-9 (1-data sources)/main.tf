# You can find aws data sources on this link: https://registry.terraform.io/providers/hashicorp/aws/latest/docs

provider "aws" {}

data "aws_availability_zones" "working" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
data "aws_vpcs" "my_vpcs" {}
data "aws_vpc" "prod_vpc" {
  tags = {
    Name = "prod"
  }
}

output "data_availableZones" {
  value = data.aws_availability_zones.working.names[1]
}
output "aws_caller_identity" {
  value = data.aws_caller_identity.current.account_id
}
output "aws_region_name" {
  value = data.aws_region.current.name
}
output "aws_region_desription" {
  value = data.aws_region.current.description
}
output "aws_vpcs" {
  value = data.aws_vpcs.my_vpcs.ids
}
output "prod_vpc_id" {
  value = data.aws_vpc.prod_vpc.id
}
output "prod_vpc_cidr" {
  value = data.aws_vpc.prod_vpc.cidr_block
}