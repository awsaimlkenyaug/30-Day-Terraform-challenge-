locals {
  cluster_name = "${var.name_prefix}-${var.environment}-eks"
  namespace    = "app-namespace" # Custom namespace instead of default
}

resource "aws_eks_cluster" "main" {
  name     = local.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
  version  = "1.27"

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = false # Disable public endpoint
    security_group_ids      = [aws_security_group.eks_cluster.id]
  }

  # Enable secrets encryption
  encryption_config {
    provider {
      key_arn = aws_kms_key.eks_encryption.arn
    }
    resources = ["secrets"]
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_service_policy,
  ]

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Name        = local.cluster_name
  }
}

# KMS key for EKS secrets encryption
resource "aws_kms_key" "eks_encryption" {
  description             = "KMS key for EKS cluster secrets encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name        = "${local.cluster_name}-encryption-key"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${local.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.eks_nodes.arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  instance_types = ["t3.medium"]

  depends_on = [
    aws_iam_role_policy_attachment.eks_nodes_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_container_registry,
  ]

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Name        = "${local.cluster_name}-node-group"
  }
}

resource "aws_security_group" "eks_cluster" {
  name_prefix = "${local.cluster_name}-sg"
  description = "Security group for EKS cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks # Use allowed CIDR blocks instead of 0.0.0.0/0
    description = "Allow HTTPS from specified CIDR blocks"
  }

  # Restrict egress to specific ports and protocols
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS outbound traffic"
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP outbound traffic"
  }

  tags = {
    Name        = "${local.cluster_name}-sg"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

resource "aws_iam_role" "eks_cluster" {
  name = "${local.cluster_name}-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role" "eks_nodes" {
  name = "${local.cluster_name}-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "eks_service_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "eks_nodes_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes.name
}

resource "aws_iam_role_policy_attachment" "eks_container_registry" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes.name
}

# Create custom namespace
resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = local.namespace

    labels = {
      name        = local.namespace
      environment = var.environment
    }
  }
}

# Deploy sample application with security best practices
resource "kubernetes_deployment" "sample_app" {
  metadata {
    name      = "sample-app"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "sample-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "sample-app"
        }
      }

      spec {
        # Security context for pod
        security_context {
          fs_group        = 1000
          run_as_non_root = true
          run_as_user     = 1000

          # Disable NET_RAW capability
          seccomp_profile {
            type = "RuntimeDefault"
          }
        }

        container {
          name = "nginx"
          # Use image digest instead of tag
          image = "nginx@sha256:4c0fdaa8b6341bfdeca5f18f7837462c80cff90527ee35ef185571e1c327beac"

          # Always pull the image
          image_pull_policy = "Always"

          # Container security context
          security_context {
            allow_privilege_escalation = false
            capabilities {
              drop = ["ALL"]
            }
            read_only_root_filesystem = true
          }

          # Liveness probe
          liveness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 10
            period_seconds        = 10
          }

          # Readiness probe
          readiness_probe {
            http_get {
              path = "/"
              port = 80
            }
            initial_delay_seconds = 5
            period_seconds        = 5
          }

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "256Mi"
            }
          }

          # Add volume mount for temporary files since root filesystem is read-only
          volume_mount {
            name       = "tmp"
            mount_path = "/tmp"
          }
        }

        # Volume for temporary files
        volume {
          name = "tmp"
          empty_dir {}
        }
      }
    }
  }
}

resource "kubernetes_service" "sample_app" {
  metadata {
    name      = "sample-app"
    namespace = kubernetes_namespace.app_namespace.metadata[0].name
  }

  spec {
    selector = {
      app = "sample-app"
    }

    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }

    type = "LoadBalancer"
  }
}