variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be launched"
  type        = string
}


variable "security_group_id" {
  description = "The ID of the security group to associate with the EC2 instance"
  type        = string
}


variable "common_tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}
