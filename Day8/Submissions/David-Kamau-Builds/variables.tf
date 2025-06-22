variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "subnet_id" {
  description = "Subnet ID for EC2 instances"
  type        = string
}

variable "security_group_ids" {
  description = "Security group IDs to attach to EC2 instances"
  type        = list(string)
  default     = []
}

variable "key_name" {
  description = "SSH key pair name for EC2 access"
  type        = string
}

variable "instance_name" {
  description = "EC2 instance name tags"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "test"
}
