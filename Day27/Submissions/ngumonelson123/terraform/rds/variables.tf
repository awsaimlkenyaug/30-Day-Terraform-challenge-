variable "vpc_east_id" {
  description = "VPC ID for us-east region"
  type        = string
}

variable "vpc_west_id" {
  description = "VPC ID for us-west region"
  type        = string
}

variable "private_subnets_east" {
  description = "Private subnet IDs for us-east region"
  type        = list(string)
}

variable "private_subnets_west" {
  description = "Private subnet IDs for us-west region"
  type        = list(string)
}