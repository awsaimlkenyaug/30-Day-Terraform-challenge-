# AWS access key 
variable "access_key" {
  description = "AWS access key for authentication"
  type        = string
  sensitive   = true
}

# AWS secret key 
variable "secret_key" {
  description = "AWS secret key for authentication"
  type        = string
  sensitive   = true
}

variable "http_port" {
  default = 80
  type = number
}



