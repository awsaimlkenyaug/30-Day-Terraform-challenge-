variable "aws_region" {
  description = "AWS region to deploy to"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "igw_name" {
  description = "Name tag for the Internet Gateway"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone to deploy into"
  type        = string
}

variable "subnet_name" {
  description = "Name tag for the subnet"
  type        = string
}

variable "route_table_name" {
  description = "Name tag for the route table"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}
