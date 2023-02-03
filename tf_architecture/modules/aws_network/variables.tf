variable "default_tags" {
  type        = map(any)
  description = "Default tags to be applied to all AWS resources"
}

variable "project_name" {
  default     = "docker-assignment"
  type        = string
  description = "Name of the project - to be used as prefix"
}

variable "region" {
  default     = "us-east-1"
  type        = string
  description = "AWS region in which our architecture is being deployed"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR range of VPC for the environment"
}

# Public subnets in VPC
variable "public_subnet_cidr" {
  type        = string
  description = "Public Subnet CIDR"
}

