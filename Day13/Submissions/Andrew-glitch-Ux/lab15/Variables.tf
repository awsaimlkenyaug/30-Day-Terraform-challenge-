variable "backend_bucket" {
  description = "S3 bucket name for remote backend"
  type        = string
}

variable "backend_key" {
  description = "Path to state file in S3"
  type        = string
}

variable "backend_region" {
  description = "AWS region for backend"
  type        = string
}

variable "dynamodb_table" {
  description = "DynamoDB table for state locking"
  type        = string
}

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "db_name" {
  description = "Name of the RDS database"
  type        = string
}

variable "db_port" {
  description = "Port for the RDS database"
  type        = number
}

variable "db_instance_class" {
  description = "RDS instance type"
  type        = string
}

variable "db_engine" {
  description = "RDS database engine (e.g., mysql)"
  type        = string
}

variable "db_engine_version" {
  description = "Version of the database engine"
  type        = string
}

variable "db_subnet_ids" {
  description = "List of subnet IDs for RDS instance"
  type        = list(string)
}

variable "db_security_group_ids" {
  description = "List of security group IDs for RDS instance"
  type        = list(string)
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "environment" {
  description = "Environment name to tag resources"
  type        = string
}

variable "db_allocated_storage" {
  description = "Allocated storage in GB for the DB"
  type        = number
}

variable "port" {
  description = "Database port"
  type        = number
}

variable "allowed_cidr_blocks" {
  description = "List of allowed CIDR blocks for ingress"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Replace with var if using in root
}

variable "egress_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks allowed for egress"
}


