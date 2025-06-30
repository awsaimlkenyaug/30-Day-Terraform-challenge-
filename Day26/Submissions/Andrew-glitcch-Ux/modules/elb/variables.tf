variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for the ALB"
  type        = string
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "target_group_port" {
  description = "Port the target group listens on"
  type        = number
}

variable "vpc_id" {
  description = "VPC ID in which to create the target group"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
}
