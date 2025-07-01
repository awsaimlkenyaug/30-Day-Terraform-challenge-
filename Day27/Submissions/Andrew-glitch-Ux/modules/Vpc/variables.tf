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
  description = "CIDR block for the first public subnet"
  type        = string
}

variable "public_subnet_cidr_2" {
  description = "CIDR block for the second public subnet"
  type        = string
}

variable "private_subnet_cidr_1" {
  description = "CIDR block for the first private subnet"
  type        = string
}

variable "private_subnet_cidr_2" {
  description = "CIDR block for the second private subnet"
  type        = string
}

variable "public_subnet_name_1" {
  description = "Name tag for the first public subnet"
  type        = string
}

variable "public_subnet_name_2" {
  description = "Name tag for the second public subnet"
  type        = string
}

variable "private_subnet_name_1" {
  description = "Name tag for the first private subnet"
  type        = string
}

variable "private_subnet_name_2" {
  description = "Name tag for the second private subnet"
  type        = string
}

variable "availability_zone_1" {
  description = "First availability zone (e.g., eu-north-1a)"
  type        = string
}

variable "availability_zone_2" {
  description = "Second availability zone (e.g., eu-north-1b)"
  type        = string
}

variable "route_table_name" {
  description = "Name tag for the public route table"
  type        = string
}

variable "private_route_table_name" {
  description = "Name tag for the private route table"
  type        = string
}

variable "nat_eip_name" {
  description = "Name tag for the NAT EIP"
  type        = string
}

variable "nat_gateway_name" {
  description = "Name tag for the NAT Gateway"
  type        = string
}

variable "common_tags" {
  description = "Map of common tags applied to all resources"
  type        = map(string)
}
