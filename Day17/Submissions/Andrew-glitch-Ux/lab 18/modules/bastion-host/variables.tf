variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "name" {
  type = string
}
variable "public_key" {
  description = "The SSH public key content"
  type        = string
}

