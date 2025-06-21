variable "region" {
  type        = string
  description = "AWS region"
}

variable "ami_id" {
  type        = string
  description = "EC2 AMI ID"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
}

variable "ssh_ingress_cidr_blocks" {
  type        = list(string)
  description = "SSH ingress CIDRs"
}

variable "http_ingress_cidr_blocks" {
  type        = list(string)
  description = "HTTP ingress CIDRs"
}

variable "egress_cidr_blocks" {
  type        = list(string)
  description = "Egress CIDRs"
}

variable "user_data_enabled" {
  type        = bool
  description = "Enable user data"
}

variable "app_name" {
  type        = string
  description = "Application name"
}

variable "desired_capacity" {
  type        = number
  description = "Desired ASG instances"
}

variable "min_size" {
  type        = number
  description = "Minimum ASG instances"
}

variable "max_size" {
  type        = number
  description = "Maximum ASG instances"
}
variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks for public subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "AZs to use for subnets"
}
