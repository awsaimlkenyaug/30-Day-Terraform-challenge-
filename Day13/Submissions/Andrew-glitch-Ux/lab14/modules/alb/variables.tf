variable "app_name" {
  type        = string
  description = "Name of the application used for naming resources"
}

variable "alb_sg_id" {
  type        = string
  description = "Security Group ID to associate with the ALB"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs to attach to the ALB"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the ALB and target group"
}
