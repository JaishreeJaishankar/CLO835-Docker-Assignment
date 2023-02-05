module "ecr" {
  source               = "../modules/aws_ecr"
  default_tags         = var.default_tags
}
