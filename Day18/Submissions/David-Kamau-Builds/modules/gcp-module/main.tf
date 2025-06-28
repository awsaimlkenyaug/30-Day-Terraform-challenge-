locals {
  network_name = "${var.name_prefix}-${var.environment}-network"
}

resource "google_compute_network" "vpc" {
  name                    = local.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${local.network_name}-subnet"
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc.id
  
  # Enable private IP Google access
  private_ip_google_access = true
  
  # Enable VPC flow logs
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }

  secondary_ip_range {
    range_name    = "${local.network_name}-pods"
    ip_cidr_range = var.pods_cidr
  }

  secondary_ip_range {
    range_name    = "${local.network_name}-services"
    ip_cidr_range = var.services_cidr
  }
}

resource "google_compute_firewall" "allow_internal" {
  name    = "${local.network_name}-allow-internal"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [var.subnet_cidr]
}

resource "google_compute_firewall" "allow_https" {
  name    = "${local.network_name}-allow-https"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web"]
}

resource "google_container_cluster" "primary" {
  name     = "${var.name_prefix}-${var.environment}-gke"
  location = var.region

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  # Enable private cluster
  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  # Disable client certificate authentication
  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  # Enable master authorized networks
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.authorized_networks_cidr
      display_name = "Authorized Network"
    }
  }

  # Enable binary authorization
  binary_authorization {
    evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
  }

  # Enable network policy and intranode visibility
  network_policy {
    enabled = true
  }
  
  # Enable intranode visibility
  enable_intranode_visibility = true
  
  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }
  
  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }

  # Enable Google Groups for RBAC
  authenticator_groups_config {
    security_group = "gke-security-groups@${var.domain}"
  }

  # Set release channel
  release_channel {
    channel = "REGULAR"
  }

  # Add labels
  resource_labels = {
    environment = var.environment
    managed_by  = "terraform"
    project     = var.name_prefix
  }

  remove_default_node_pool = true
  initial_node_count       = 1

  ip_allocation_policy {
    cluster_secondary_range_name  = "${local.network_name}-pods"
    services_secondary_range_name = "${local.network_name}-services"
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${google_container_cluster.primary.name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  # Enable auto-repair and auto-upgrade
  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only"
    ]

    labels = {
      env = var.environment
    }

    machine_type = "e2-medium"
    tags         = ["gke-node", "web"]

    # Enable GKE Metadata Server
    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    # Enable Secure Boot for Shielded GKE Nodes
    shielded_instance_config {
      enable_secure_boot = true
    }

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}