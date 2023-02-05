terraform {
  backend "s3" {
    bucket = "docker-assignment-186164216-s3"
    key    = "ecr/terraform.tfstate"
    region = "us-east-1"
  }
}