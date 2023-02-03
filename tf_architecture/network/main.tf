module "network" {
  source               = "../modules/aws_network"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  default_tags         = var.default_tags
}
