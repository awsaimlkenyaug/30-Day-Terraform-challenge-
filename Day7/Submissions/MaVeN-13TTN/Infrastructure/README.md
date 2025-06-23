# Day 7 Infrastructure Diagrams

This folder contains Python scripts to generate visual infrastructure diagrams for the Day 7 Terraform state isolation implementations.

## Overview

The Day 7 challenge focuses on two different approaches to Terraform state isolation:

1. **Workspace Isolation**: Uses Terraform workspaces with a single configuration
2. **File Layout Isolation**: Uses separate directories and modules for each environment

## Folder Structure

```
Infrastructure/
├── scripts/                                    # Python diagram generation scripts
│   ├── workspace_isolation_diagram.py         # Workspace isolation diagram
│   ├── file_layout_isolation_diagram.py       # File layout isolation diagram
│   └── generate_all_diagrams.py               # Generate all diagrams
├── diagrams/                                   # Generated PNG diagram files
│   ├── workspace_isolation_infrastructure.png
│   └── file_layout_isolation_infrastructure.png
└── README.md                                   # This file
```

## Prerequisites

- Python 3.6+
- `diagrams` library installed (`pip install diagrams`)
- Graphviz installed on your system

## Usage

### Generate All Diagrams

```bash
cd scripts/
python generate_all_diagrams.py
```

### Generate Individual Diagrams

```bash
# Workspace isolation diagram
python workspace_isolation_diagram.py

# File layout isolation diagram  
python file_layout_isolation_diagram.py
```

## Diagram Descriptions

### Workspace Isolation Architecture

Shows how a single Terraform configuration uses workspaces to manage multiple environments:

- **Single Configuration**: One set of Terraform files with conditional logic
- **Shared State Backend**: Single S3 bucket with workspace-specific state files
- **Environment Differentiation**: Uses `terraform.workspace` variable for environment-specific settings
- **Workspaces**: dev, staging, and prod workspaces with different resource configurations

**Key Features:**
- Simplified code maintenance (single codebase)
- Workspace-aware resource naming
- Shared backend with workspace isolation
- Environment-specific scaling and instance types

### File Layout Isolation Architecture

Shows how separate directories and modules provide complete environment isolation:

- **Modular Architecture**: Reusable modules for VPC, security groups, compute, and load balancer
- **Environment Separation**: Complete isolation with separate directories
- **Independent State**: Each environment has its own state file path
- **Module Reusability**: Common modules used across all environments

**Key Features:**
- Complete environment separation
- Modular and reusable infrastructure components
- Independent state management per environment
- Flexible per-environment configurations

## Infrastructure Components

Both architectures implement the same core infrastructure:

### Network Components
- **VPC**: Environment-specific CIDR blocks (10.0.0.0/16, 10.1.0.0/16, 10.2.0.0/16)
- **Public Subnets**: Multi-AZ deployment for high availability
- **Private Subnets**: For future backend services
- **Internet Gateway**: Public internet access
- **Route Tables**: Traffic routing configuration

### Compute Components
- **Auto Scaling Groups**: Environment-specific scaling policies
- **Launch Templates**: Instance configuration templates
- **EC2 Instances**: Web servers with user data scripts
- **Security Groups**: Network access control

### Load Balancing
- **Application Load Balancer**: HTTP/HTTPS traffic distribution
- **Target Groups**: Health check and routing configuration
- **Listeners**: Traffic forwarding rules

### State Management
- **S3 Backend**: Remote state storage
- **DynamoDB**: State locking mechanism
- **Encryption**: State file encryption at rest

## Environment Configurations

### Development
- **Instance Type**: t2.micro (cost-optimized)
- **Scaling**: 1-3 instances
- **Features**: Basic monitoring, relaxed security

### Staging
- **Instance Type**: t3.small (production-like)
- **Scaling**: 1-5 instances  
- **Features**: Enhanced monitoring, production-similar settings

### Production
- **Instance Type**: t3.medium (performance-optimized)
- **Scaling**: 2-10 instances
- **Features**: Full monitoring, enhanced security, deletion protection

## Generated Diagrams

The generated diagrams provide visual representations that help understand:

1. **Architecture Differences**: Clear visualization of workspace vs file layout approaches
2. **State Management**: How state is stored and managed in each approach
3. **Resource Relationships**: Connections between different infrastructure components
4. **Environment Isolation**: How each approach achieves environment separation
5. **Scaling Differences**: Environment-specific configurations and scaling policies

## Notes

- Diagrams are generated as PNG files in the `diagrams/` folder
- The scripts use the `diagrams` library which provides AWS-specific icons
- Generated diagrams show logical relationships and simplified connections for clarity
- Real infrastructure includes additional networking and security configurations not shown for diagram simplicity

## Troubleshooting

If you encounter issues:

1. **Import Errors**: Ensure you're running scripts from the `scripts/` directory
2. **Missing Diagrams Library**: Install with `pip install diagrams`
3. **Graphviz Issues**: Install Graphviz on your system (varies by OS)
4. **Permission Errors**: Ensure write permissions in the `diagrams/` folder

## Related Files

- `../terraform/workspace-isolation/`: Workspace isolation Terraform configuration
- `../terraform/file-layout-isolation/`: File layout isolation Terraform configuration
- `../docs/`: Documentation and blog posts about state isolation approaches
