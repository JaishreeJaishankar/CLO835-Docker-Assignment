provider "aws" {
  region = var.region
}

# List of all available availability zones
data "aws_availability_zones" "available" {
  state = "available"
}

# Local variables
locals {
  default_tags = var.default_tags
  name_prefix = "${var.project_name}"
}

# VPC in which our architecture will be deployed
resource "aws_vpc" "mainVPC" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  
  tags = merge(
    var.default_tags, {
      Name = "${local.name_prefix}-VPC"
    }
  )
}

# Public subnets
resource "aws_subnet" "publicSubnet" {
  vpc_id            = aws_vpc.mainVPC.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  
  tags = merge(
    local.default_tags, {
      Name = "${local.name_prefix}-Public-Subnet-1"
    }
  )
}

# Internet gateway
resource "aws_internet_gateway" "internetGateway" {
  vpc_id = aws_vpc.mainVPC.id

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-IGW"
    }
  )
}

# Elastic IP
resource "aws_eip" "eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.internetGateway]
  
  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-EIP"
    }
  )
}

# Route table for public subnets
resource "aws_route_table" "publicRouteTable" {
  vpc_id = aws_vpc.mainVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internetGateway.id
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-Public-Route-Table"
    }
  )
}

# Assosciating public subnets with the public route table
resource "aws_route_table_association" "publicRouteTableAssociation" {
  route_table_id = aws_route_table.publicRouteTable.id
  subnet_id      = aws_subnet.publicSubnet.id
}

