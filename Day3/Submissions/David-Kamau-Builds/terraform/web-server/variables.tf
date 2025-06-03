variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}
variable "availability_zone1" {
  description = "First AZ for the public subnet"
  default     = "us-east-1a"
}
variable "availability_zone2" {
  description = "Second AZ for high availability"
  default     = "us-east-1b"
}
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}
variable "public_subnet_cidr1" {
  description = "CIDR block for first public subnet"
  default     = "10.0.1.0/24"
}
variable "public_subnet_cidr2" {
  description = "CIDR block for second public subnet"
  default     = "10.0.2.0/24"
}
variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}
variable "key_name" {
  description = "EC2 key pair name"
  type        = string
  default     = "my-web-server-key-pair"
}
variable "allowed_ip" {
  description = "Your IP for SSH access (CIDR)"
  default     = "0.0.0.0/0"
}

variable "project_name" {
  description = "Name of the project for resource naming"
  type        = string
  default     = "web-server"
}

variable "environment" {
  description = "Deployment environment"
  default     = "test"
}