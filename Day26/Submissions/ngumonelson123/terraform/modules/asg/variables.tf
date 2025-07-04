variable "launch_template_id" {}
variable "target_group_arn" {}
variable "subnet_ids" {
  type = list(string)
}
