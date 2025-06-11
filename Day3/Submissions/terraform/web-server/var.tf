variable "aws_access_key" {
  type        = string
  description = "description"
}
variable "aws_secret_key" {
  type        = string
  description = "description"
}
variable "server_port" {
  type        = number
  description = "Port on which the web server will run"
  default     = 8080
}
