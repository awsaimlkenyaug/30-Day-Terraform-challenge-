variable "deploy_us_east" {
  type    = bool
  default = true
}

variable "deploy_us_west" {
  type    = bool
  default = false
}
variable "ami_id" {
  default     = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI in your region
  description = "AMI ID for the EC2 instances"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "Instance type"
}

variable "instances" {
  default     = ["web-1", "web-2", "web-3"]
  description = "List of EC2 instance names"
}

