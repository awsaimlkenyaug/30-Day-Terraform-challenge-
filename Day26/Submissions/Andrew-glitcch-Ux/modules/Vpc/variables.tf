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

variable "public_subnet_cidr_1" {
  description = "CIDR block for first public subnet"
  type        = string
}

variable "public_subnet_name_1" {
  description = "Name for the first public subnet"
  type        = string
}

variable "availability_zone_1" {
  description = "Availability zone for the first public subnet"
  type        = string
}

# 👇 Add these second subnet vars too to fix 'not expected' error:
variable "public_subnet_cidr_2" {
  description = "CIDR block for second public subnet"
  type        = string
}

variable "public_subnet_name_2" {
  description = "Name for the second public subnet"
  type        = string
}

variable "availability_zone_2" {
  description = "Availability zone for the second public subnet"
  type        = string
}

variable "route_table_name" {
  description = "Name tag for the public route table"
  type        = string
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}
