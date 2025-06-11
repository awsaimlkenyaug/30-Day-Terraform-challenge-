# variables.tf

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}
variable "server_port" {
  type        = number
  description = "Port on which the web server will run"
  default     = 8080
}


variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the resources will be deployed"
}




