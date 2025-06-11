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

# Port number that the server will listen on
variable "server_port" {
  description = "Port number to allow in the security group and use in user_data"
  type        = number
  default     = 8080
}
