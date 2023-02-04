variable "default_tags" {
  default = {
    "Owner" = "Jaishree"
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be applied to all AWS resources"
}