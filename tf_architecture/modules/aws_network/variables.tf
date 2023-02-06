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

# Public subnets in VPC
variable "public_subnet_cidr" {
  default     = "172.31.128.0/20" 
  type        = string
  description = "Public Subnet CIDR"
}

