variable "region" {
  type        = string
  description = "AWS region to deploy resources"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet"
}

variable "deploy_web_server" {
  type        = bool
  description = "Whether to deploy the web server module"
  default     = true
}

variable "ami_id" {
  type        = string
  description = "AMI ID to use for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}
