variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "alb_ingress_port" {
  type = number
}

variable "alb_ingress_cidr_blocks" {
  type = list(string)
}

variable "alb_egress_cidr_blocks" {
  type = list(string)
}

variable "internal" {
  type = bool
}

variable "enable_deletion_protection" {
  type = bool
}

variable "target_group_name" {
  type = string
}

variable "target_group_port" {
  type = number
}

variable "target_group_protocol" {
  type = string
}

variable "target_type" {
  type = string
}

variable "health_check_interval" {
  type = number
}

variable "health_check_path" {
  type = string
}

variable "health_check_protocol" {
  type = string
}

variable "health_check_timeout" {
  type = number
}

variable "healthy_threshold" {
  type = number
}

variable "unhealthy_threshold" {
  type = number
}

variable "health_check_matcher" {
  type = string
}

variable "listener_port" {
  type = number
}

variable "listener_protocol" {
  type = string
}

variable "tags" {
  type = map(string)
}
