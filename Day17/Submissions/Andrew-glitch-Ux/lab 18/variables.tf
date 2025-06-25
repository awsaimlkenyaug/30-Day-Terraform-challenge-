variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
}

# VPC
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

# Public Subnet (old)
variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "public_az" {
  description = "Availability zone for the public subnet"
  type        = string
}

variable "public_subnet_name" {
  description = "Name tag for the public subnet"
  type        = string
}

# Public Subnet A & B (new)
variable "public_subnet_a_name" {
  type = string
}

variable "public_subnet_b_name" {
  type = string
}

variable "public_subnet_a_cidr" {
  type = string
}

variable "public_subnet_b_cidr" {
  type = string
}

variable "public_subnet_a_az" {
  type = string
}

variable "public_subnet_b_az" {
  type = string
}

# Private Subnet
variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "private_az" {
  description = "Availability zone for the private subnet"
  type        = string
}

variable "private_subnet_name" {
  description = "Name tag for the private subnet"
  type        = string
}

# ALB
variable "alb_name" {
  description = "Name for the Application Load Balancer"
  type        = string
}

variable "target_group_arn" {
  description = "Target group ARN for forwarding traffic"
  type        = string
}

# ASG
variable "asg_name" {
  description = "Name for the Auto Scaling Group"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of instances in ASG"
  type        = number
}

variable "min_size" {
  description = "Minimum number of instances in ASG"
  type        = number
}

variable "max_size" {
  description = "Maximum number of instances in ASG"
  type        = number
}

variable "asg_tags" {
  description = "Tags to apply to ASG instances"
  type        = map(string)
}

# Bastion Host
variable "bastion_instance_type" {
  description = "Instance type for the bastion host"
  type        = string
}

variable "bastion_name" {
  description = "Name tag for the bastion host"
  type        = string
}

variable "public_key_path" {
  description = "Path to the SSH public key file"
  type        = string
}
