variable "ami_id" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "instance_name" {}
variable "environment" {
  description = "Deployment environment like dev, staging, production"
}
