variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "name" {
  description = "Name prefix for tags"
  type        = string
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}
