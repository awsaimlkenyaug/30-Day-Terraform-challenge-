# AWS Variables
variable "aws_region" {}
variable "aws_vpc_cidr" {}
variable "aws_vpc_name" {}

variable "aws_subnet_cidr_1" {}
variable "aws_subnet_cidr_2" {}
variable "aws_az_1" {}
variable "aws_az_2" {}
variable "aws_subnet_name_1" {}
variable "aws_subnet_name_2" {}

variable "eks_cluster_name" {}
variable "eks_cluster_role_name" {}
variable "eks_cluster_policy_arn" {}

# GCP Variables (placeholders only)
variable "gcp_project" {}
variable "gcp_region" {}
variable "gcp_vpc_name" {}
variable "gcp_subnet_name" {}
variable "gcp_subnet_cidr" {}
