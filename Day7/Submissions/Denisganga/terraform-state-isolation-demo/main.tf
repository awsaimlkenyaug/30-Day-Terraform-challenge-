resource "local_file" "example" {
  filename = "example-${terraform.workspace}.txt"
  content  = "This file is created in workspace: ${terraform.workspace}"
}
