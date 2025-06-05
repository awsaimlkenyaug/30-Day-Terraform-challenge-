variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR Block"
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "TerraformDay4VPC"
}

variable "variables_sub_cidr" {
  description = "CIDR block for subnet"
  default     = "10.0.202.0/24"
}

variable "variables_sub_az" {
  description = "Availability Zone"
  default     = "us-east-1a"
}

variable "variables_sub_auto_ip" {
  description = "Auto-assign public IP"
  default     = true
}
