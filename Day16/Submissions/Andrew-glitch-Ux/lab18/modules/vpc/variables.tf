variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "public_subnet_a_id" {
  description = "ID of public subnet A"
  type        = string
}

variable "public_subnet_b_id" {
  description = "ID of public subnet B"
  type        = string
}
