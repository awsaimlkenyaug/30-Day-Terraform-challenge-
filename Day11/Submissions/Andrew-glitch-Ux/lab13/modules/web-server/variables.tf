variable "name" { type = string }
variable "ami" { type = string }
variable "instance_type" { type = string }
variable "vpc_id" { type = string }
variable "subnet_id" { type = string }
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
variable "deploy_instance" { type = bool }

