# For both modules

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "launch_template_id" {
  description = "ID of the launch template"
  type        = string
}
