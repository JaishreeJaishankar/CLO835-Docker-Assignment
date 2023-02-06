module "network" {
  source               = "../modules/aws_network"
  default_tags         = var.default_tags
}
