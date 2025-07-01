# ========== Security Group ==========
variable "security_group_name" {
  description = "Name tag for the security group"
  type        = string
}

variable "security_group_description" {
  description = "Description for the security group"
  type        = string
}

variable "sg_ingress_description" {
  description = "Description for the ingress rule"
  type        = string
}

variable "sg_ingress_from_port" {
  description = "Ingress rule from port"
  type        = number
}

variable "sg_ingress_to_port" {
  description = "Ingress rule to port"
  type        = number
}

variable "sg_ingress_protocol" {
  description = "Ingress rule protocol (e.g. tcp)"
  type        = string
}

variable "sg_ingress_cidr_blocks" {
  description = "List of CIDR blocks allowed for ingress"
  type        = list(string)
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}

variable "vpc_id" {
  description = "VPC ID to associate security group"
  type        = string
}
