variable "region" {
  type        = string
  description = "AWS region"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to launch the instance in"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for security group"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "user_data_enabled" {
  type        = bool
  description = "Whether to enable user data for instance"
  default     = false
}

variable "ingress_port" {
  type        = number
  description = "Port to allow for incoming traffic (e.g. 80 for HTTP)"
  default     = 80
}
