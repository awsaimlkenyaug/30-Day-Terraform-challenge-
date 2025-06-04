variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  type        = string
  description = "AMI to use for web servers"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "web_content" {
  type        = string
  default     = "<h1>BranTech Clustered Web Server</h1>"
}

variable "desired_capacity" {
  default = 2
}
