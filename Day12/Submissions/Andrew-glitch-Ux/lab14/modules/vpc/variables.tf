variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDRs for public subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones to use"
}

variable "app_name" {
  type        = string
  description = "Application name used in naming resources"
}
