variable "region" {
  description = "AWS region to deploy the clustered web server"
  type        = string
  default     = "us-east-1"
}

variable "instance_count" {
  description = "Number of EC2 instances in the cluster"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances (Ubuntu 20.04 LTS)"
  type        = string
  default     = "ami-0e86e20dae9224db8" # Update for your region
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "my-key-pair" # Replace with your key pair name
}