#Define the provider
provider "aws" {
  region = var.region
}

# Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Calling RemoteState based on the Environments
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "${var.project_name}-186164216-s3"
    key    = "network/terraform.tfstate"
    region = "us-east-1"
  }
}

# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

# Define tags locally
locals {
  default_tags = var.default_tags
  name_prefix = "${var.project_name}"
}

# Provision SSH key pair for the instances
resource "aws_key_pair" "sshKey" {
  key_name   = local.name_prefix
  public_key = file("${local.name_prefix}.pub")
}

# Creating Compute Instance
resource "aws_instance" "computeInstance" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.sshKey.key_name
  subnet_id                   = data.terraform_remote_state.network.outputs.public_subnet_id
  security_groups             = [aws_security_group.computeSG.id]
  associate_public_ip_address = true
  iam_instance_profile        = "LabInstanceProfile"
  user_data                   = file("${path.module}/user_data.sh")
  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.default_tags,
    {
      Name = "${local.name_prefix}-Compute"
    }
  )
}