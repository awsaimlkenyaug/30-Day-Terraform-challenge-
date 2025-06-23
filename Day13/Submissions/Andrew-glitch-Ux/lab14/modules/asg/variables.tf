variable "ami_id" {
  type        = string
  description = "AMI ID for EC2 instances"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for launching instances"
}

variable "instance_sg_id" {
  type        = string
  description = "Security Group ID for EC2 instances"
}

variable "target_group_arn" {
  type        = string
  description = "ARN of the ALB target group"
}

variable "user_data_enabled" {
  type        = bool
  description = "Enable user_data script"
}

variable "ssh_ingress_cidr_blocks" {
  type        = list(string)
  description = "CIDRs allowed SSH"
}

variable "http_ingress_cidr_blocks" {
  type        = list(string)
  description = "CIDRs allowed HTTP"
}

variable "egress_cidr_blocks" {
  type        = list(string)
  description = "CIDRs allowed for egress"
}

variable "app_name" {
  type        = string
  description = "Application name"
}

variable "desired_capacity" {
  type        = number
  description = "ASG desired capacity"
}

variable "min_size" {
  type        = number
  description = "ASG min size"
}

variable "max_size" {
  type        = number
  description = "ASG max size"
}


