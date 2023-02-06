provider "aws" {
  region = var.region
}

resource "aws_default_vpc" "mainVPC"{}

# List of all available availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Local variables
locals {
  default_tags = var.default_tags
  name_prefix = "${var.project_name}"
}

# Public subnet
resource "aws_subnet" "publicSubnet" {
  vpc_id            = aws_default_vpc.mainVPC.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  
  tags = merge(
    local.default_tags, {
      Name = "${local.name_prefix}-Public-Subnet-1"
    }
  )
}

