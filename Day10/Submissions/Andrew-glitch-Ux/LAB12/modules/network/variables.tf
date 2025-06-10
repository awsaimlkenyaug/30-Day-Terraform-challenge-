variable "vpc_id" {
  description = "VPC ID to attach subnets to"
  type        = string
}

variable "subnets" {
  description = "Map of subnets with cidr_block and az"
  type = map(object({
    cidr_block = string
    az         = string
  }))
}

variable "extra_tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
