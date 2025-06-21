variable "user_names" {
  type    = list(string)
  default = ["neo", "trinity", "morpheus"]
}

variable "eu_region" {
  type    = string
  default = "eu-north-1"
}

variable "us_region" {
  type    = string
  default = "us-east-1"
}

variable "deploy_to_eu" {
  description = "Set true to deploy in eu-north-1, false for us-east-1"
  type        = bool
  default     = true
}

variable "subnets" {
  description = "Map of subnets with CIDR and AZ"
  type = map(object({
    cidr_block = string
    az         = string
  }))
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "owner" {
  type    = string
  default = "Andrew"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
  default     = "lab12-vpc"
}
