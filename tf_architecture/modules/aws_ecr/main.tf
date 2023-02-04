# Local variables
locals {
  default_tags = var.default_tags
  name_prefix = "${var.project_name}"
}

#Application image repository
resource "aws_ecr_repository" "application" {
  name = "app-image-${local.name_prefix}"
  tags = merge(
    var.default_tags, {
      Name = "docker-app-image-${local.name_prefix}"
    }
  )
}

#Database image repository
resource "aws_ecr_repository" "database" {
  name = "database-image-${local.name_prefix}"
  tags = merge(
    var.default_tags, {
      Name = "docker-database-image-${local.name_prefix}"
    }
  )
}
