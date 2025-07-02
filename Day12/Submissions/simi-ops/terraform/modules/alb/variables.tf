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

variable "instance_ids" {
  description = "List of EC2 instance IDs to attach to the target group"
  type        = list(string)
  default     = []
}

# Add optional variables for advanced configurations
variable "enable_stickiness" {
  description = "Enable session stickiness for the target group"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}