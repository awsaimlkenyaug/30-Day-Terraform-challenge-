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
  description = "List of availability zones for subnets"
  type        = list(string)
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
}

variable "db_port" {
  description = "Port used by the DB to allow inbound traffic"
  type        = number
}

variable "db_allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to access the DB"
  type        = list(string)
}

variable "egress_cidr_blocks" {
  description = "List of CIDR blocks allowed for all outbound traffic"
  type        = list(string)
}
