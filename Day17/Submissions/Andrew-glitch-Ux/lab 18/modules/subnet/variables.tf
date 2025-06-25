variable "name" {
  description = "Name tag for the subnet"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the subnet"
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone for the subnet"
  type        = string
}

variable "map_public_ip_on_launch" {
  description = "Whether to map public IP on launch"
  type        = bool
}
