variable "default_tags" {
  type        = map(any)
  description = "Default tags to be applied to all AWS resources"
}

variable "project_name" {
  default     = "clo835-docker-assignment"
  type        = string
  description = "Name of the project - to be used as prefix"
}