variable "name" {
  description = "Base name used for naming and tagging all VPC-related resources"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC (e.g. 10.0.0.0/16)"
  type        = string
}

variable "enable_dns_support" {
  description = "Whether to enable DNS support for the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames for the VPC"
  type        = bool
  default     = true
}

variable "public_subnets" {
  description = <<EOT
Map of public subnets. Each entry must include:
  - cidr_block: CIDR block for the subnet
  - az: Availability zone

Example:
{
  "a" = { cidr_block = "xxxxxxx", az = "xxxxxxxxx" },
  "b" = { cidr_block = "xxxxxxx", az = "xxxxxxxxx" }
}
EOT
  type = map(object({
    cidr_block = string
    az         = string
  }))
}

variable "tags" {
  description = "Global tags to apply to all resources"
  type        = map(string)
  default     = {}
}
