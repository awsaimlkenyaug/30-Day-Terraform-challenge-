variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for the instances"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name"
}

variable "instance_count" {
  default = 2
}

variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}
