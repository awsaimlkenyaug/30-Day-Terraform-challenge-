variable "name" {}
variable "region" {}
variable "vpc_cidr" {}
variable "subnet_cidr" {}
variable "az" {}
variable "ami" {}
variable "instance_type" {}
variable "route_cidr" {}
variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "deploy_instance" {
  type    = bool
  default = true
}
