provider "google" {
  alias = "gcp_provider"
}

resource "google_compute_instance" "vm_instance" {
  name         = "test-vm"
  machine_type = "f1-micro"
  zone         = "us-central1-a"
}
