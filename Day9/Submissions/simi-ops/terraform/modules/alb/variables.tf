variable "environment" {
  description = "Environment name"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "security_group_id" {
  description = "Security group ID for the ALB"
  type        = string
}

variable "instance_id" {
  description = "EC2 instance ID to attach to the target group"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}