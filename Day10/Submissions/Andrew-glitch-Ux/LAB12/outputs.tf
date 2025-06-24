output "iam_user_arns" {
  value = values(module.iam_users)[*].user_arn
}
