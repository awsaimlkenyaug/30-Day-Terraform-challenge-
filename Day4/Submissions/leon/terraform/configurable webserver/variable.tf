variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID to use"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "web_content" {
  description = "HTML content for the web server"
  type        = string
  default     = "<h1>Hello from Terraform!</h1>"
}
