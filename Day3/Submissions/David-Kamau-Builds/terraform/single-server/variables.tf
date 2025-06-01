variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "Availability zone for subnet deployment"
  type        = string
  default     = "us-east-1a"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI ID"
  type        = string
  default     = "ami-0c02fb55956c7d316"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "my-key-pair"
  type        = string
}

variable "allowed_ip" {
  description = "IP allowed for SSH access"
  type        = string
  default     = "0.0.0.0/0"
}

variable "project_name" {
  description = "Name of the project for resource naming"
  type        = string
  default     = "single-server"
}

variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "SingleServerApp"
    ManagedBy   = "Terraform"
  }
}

variable "environment" {
  description = "Deployment environment"
  default     = "test"
}