provider "aws" {
  region = var.enable_multi_region ? "us-east-1" : "eu-west-1"
}

# Dynamically choose AMI
locals {
  selected_region = var.enable_multi_region ? "us-east-1" : "eu-west-1"
}

resource "aws_instance" "example" {
  count         = var.instance_count
  ami           = var.ami_map[local.selected_region]
  instance_type = "t2.micro"

  tags = {
    Name = "Example-${count.index}"
  }
}

resource "random_id" "bucket_id" {
  for_each    = var.deploy_s3 ? toset(var.bucket_names) : toset([])
  byte_length = 4
}

resource "aws_s3_bucket" "buckets" {
  for_each = var.deploy_s3 ? toset(var.bucket_names) : toset([])

  bucket        = "${each.key}-${random_id.bucket_id[each.key].hex}"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "example" {
  for_each = var.deploy_s3 ? aws_s3_bucket.buckets : {}

  bucket = each.value.id
  acl    = "private"
}
