variable "ami_id" {}
variable "instance_type" {}
variable "name" {}
variable "vpc_id" {}
variable "subnet_id" {
  description = "The subnet ID to launch the instance in"
  type        = string
}
