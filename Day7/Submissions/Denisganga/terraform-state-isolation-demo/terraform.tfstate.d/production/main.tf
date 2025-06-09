resource "local_file" "example" {
  filename = "example-dev.txt"
  content  = "This file is created in dev environment."
}
