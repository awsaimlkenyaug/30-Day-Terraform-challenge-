# ✅ Existing variables
variable "primary_region" {
  type        = string
  description = "Primary AWS region (e.g. eu-north-1)"
}

variable "secondary_region" {
  type        = string
  description = "Secondary AWS region (e.g. eu-west-1)"
}

variable "ami_id_primary" {
  type        = string
  description = "AMI ID for primary region"
}

variable "ami_id_secondary" {
  type        = string
  description = "AMI ID for secondary region"
}


variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "vpc_name" {
  type        = string
  description = "Name tag for the VPC"
}

# 🛠️ Add these new variables (required by your module inputs)

variable "primary_vpc_cidr" {
  type        = string
  description = "CIDR block for primary VPC"
}

variable "primary_public_subnet_cidr" {
  type        = string
  description = "CIDR block for public subnet in primary region"
}

variable "primary_az" {
  type        = string
  description = "Availability zone for primary region"
}

variable "secondary_vpc_cidr" {
  type        = string
  description = "CIDR block for secondary VPC"
}

variable "secondary_public_subnet_cidr" {
  type        = string
  description = "CIDR block for public subnet in secondary region"
}

variable "secondary_az" {
  type        = string
  description = "Availability zone for secondary region"
}

variable "primary_instance_name" {
  type        = string
  description = "Name of EC2 instance in primary region"
}

variable "secondary_instance_name" {
  type        = string
  description = "Name of EC2 instance in secondary region"
}
