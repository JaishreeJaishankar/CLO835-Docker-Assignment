variable "default_tags" {
  default = {
    "Owner" = "Jaishree"
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be applied to all AWS resources"
}

variable "vpc_cidr" {
  default     = "10.100.0.0/16"
  type        = string
  description = "CIDR range of VPC for the environment"
}

# Public subnets in VPC
variable "public_subnet_cidr" {
  default     = "10.100.0.0/24"
  type        = string
  description = "Public Subnet CIDR"
}
