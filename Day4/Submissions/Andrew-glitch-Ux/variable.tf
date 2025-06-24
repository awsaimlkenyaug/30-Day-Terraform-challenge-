variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name tag for the VPC"
  type        = string
  default     = "terraform-demo-vpc"
}

variable "private_subnets" {
  description = "Map of private subnet names to their subnet index"
  type        = map(number)
  default = {
    private_subnet_1 = 0
    private_subnet_2 = 1
  }
}

variable "public_subnets" {
  description = "Map of public subnet names to their subnet index"
  type        = map(number)
  default = {
    public_subnet_1 = 0
    public_subnet_2 = 1
  }
}

variable "variables_sub_cidr" {
  description = "CIDR Block for the Variables Subnet"
  type        = string
  default     = "10.0.202.0/24"
}

variable "variables_sub_az" {
  description = "Availability Zone used for Variables Subnet"
  type        = string
  default     = "eu-north-1a"
}

variable "variables_sub_auto_ip" {
  description = "Set Automatic IP Assignment for Variables Subnet"
  type        = bool
  default     = true
}
