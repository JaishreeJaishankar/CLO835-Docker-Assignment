module "compute" {
  source               = "../modules/aws_compute"
  instance_type        = var.instance_type
  default_tags         = var.default_tags
}