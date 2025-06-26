variable "ami" {}
variable "instance_type" {}
variable "instance_name" {}
variable "environment" {}
variable "subnet_id" {}
variable "vpc_security_group_ids" {
  type = list(string)
}
variable "user_data" {
  default = ""
}
