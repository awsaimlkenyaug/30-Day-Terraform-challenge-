output "instance_ips" {
  value = [for i in aws_instance.multi : i.public_ip]
}
