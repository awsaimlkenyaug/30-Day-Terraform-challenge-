# Day 4 Submission

## Personal Information
- **Name:** Ndungu Kinyanjui
- **Date:** June 2, 2025
- **GitHub Username:** MaVeN-13TTN

## Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running" (pages 60-70)
- [x] Completed Required Hands-on Labs (Lab 05: Data Sources, Lab 06: Variables)
- [x] Deployed Configurable Web Server
- [x] Deployed Clustered Web Server
- [x] Explored Terraform Documentation
- [x] Created Infrastructure Diagrams
- [x] Written Blog Post
- [x] Infrastructure Documentation Completed
- [x] All Resources Destroyed (Cost Optimization)

## Infrastructure Details

### 🚀 Deployment Status - COMPLETED ✅

### Configurable Web Server Deployment
- **Status:** ✅ DEPLOYED, TESTED, AND DESTROYED
- **Region:** us-east-1
- **Instance Type:** t3.micro
- **Instance ID:** i-02849770a698cb3ff (destroyed)
- **Public IP:** 35.153.140.5 (released)
- **Key Features:** 
  - 20+ configurable input variables with validation
  - Conditional SSH access and EIP allocation
  - Dynamic security group rules generation
  - Comprehensive outputs for integration
  - Environment-specific configurations
  - Encrypted EBS volumes

### Clustered Web Server Deployment
- **Status:** ✅ DEPLOYED, TESTED, AND DESTROYED
- **Region:** us-east-1
- **Instance Type:** t3.micro
- **Infrastructure:** 11 AWS resources deployed
- **Key Features:**
  - Auto Scaling Group (2-6 instances) across multiple AZs
  - Application Load Balancer with health checks
  - CloudWatch alarms and auto-scaling policies
  - Multi-AZ deployment for high availability
  - Target groups with proper health monitoring
  - Security groups for ALB and instances

## Labs Completed

### Lab 05: Data Sources
- **Objective:** Learn to use Terraform data sources to fetch information about existing AWS resources
- **Key Concepts:** 
  - Data blocks syntax and usage
  - Fetching AMI information
  - Referencing existing VPC and subnet data
  - Dynamic resource configuration using data sources

### Lab 06: Variables
- **Objective:** Implement input variables to make Terraform configurations reusable and flexible
- **Key Concepts:**
  - Variable definitions and types
  - Default values and validation
  - Variable files (terraform.tfvars)
  - Environment-specific configurations
  - Variable precedence and best practices

## Infrastructure Diagrams
Architecture diagrams are located in the `architecture/diagrams/` folder:
- ✅ `configurable_webserver_architecture.png` - Diagram for the configurable web server deployment
- ✅ `clustered_webserver_architecture.png` - Diagram for the clustered web server deployment

**Generation Scripts:**
- `architecture/generate_configurable_diagram.py` - Python script using diagrams library
- `architecture/generate_clustered_diagram.py` - Python script using diagrams library

## Terraform Code Structure
```
terraform/
├── configurable-webserver/
│   ├── main.tf           # Main infrastructure resources
│   ├── variables.tf      # Input variable definitions
│   ├── outputs.tf        # Output value definitions
│   └── terraform.tfvars  # Variable values
└── clustered-webserver/
    ├── main.tf           # Main infrastructure resources
    ├── variables.tf      # Input variable definitions
    ├── outputs.tf        # Output value definitions
    └── terraform.tfvars  # Variable values
```

## Key Learning Outcomes
- ✅ Mastered advanced Terraform features: variables, data sources, outputs
- ✅ Implemented DRY (Don't Repeat Yourself) principle in Terraform
- ✅ Built reusable and configurable infrastructure patterns
- ✅ Deployed highly available web applications with auto-scaling
- ✅ Created dynamic security groups with conditional rules
- ✅ Implemented proper resource dependency management
- ✅ Generated comprehensive architecture diagrams
- ✅ Applied Infrastructure as Code best practices
- ✅ Solved real-world challenges (AZ compatibility issues)
- ✅ Implemented cost-effective resource management

## Blog Post
- **Title:** "Day 4: Mastering Advanced Terraform Features - Configurable and Clustered Web Servers"
- **Status:** ✅ COMPLETED
- **File:** [blog-post.md](./blog-post.md)
- **Key Topics:** Advanced variables, data sources, outputs, auto-scaling, load balancing

## Infrastructure Documentation
- **Title:** "Infrastructure Documentation - Day 4 Advanced Terraform Features"
- **Status:** ✅ COMPLETED
- **File:** [infrastructure-documentation.md](./infrastructure-documentation.md)
- **Content:** Comprehensive technical documentation with architecture details

## Social Media Post
- **Platform:** Twitter/X
- **Text:** "🔥 Deployed a highly available web app today! I'm beginning to enjoy the benefits of IaC. #30daytfchallenge #HUG #hashicorp #HUGYDE @chiche #IaC"
- **Status:** ✅ Posted
- **URL:** https://x.com/Maven_TTN/status/1929498065448104011

## Additional Resources Used
- [Terraform Documentation - Variables](https://www.terraform.io/docs/configuration/variables.html)
- [Terraform Documentation - Data Sources](https://www.terraform.io/docs/configuration/data-sources.html)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- Chapter 2: "Terraform: Up & Running" by Yevgeniy Brikman

## Challenges Faced and Solutions
### 1. Availability Zone Compatibility Issue
- **Challenge:** t3.micro instances not supported in us-east-1e
- **Error:** "InvalidInstanceType: The instance type 't3.micro' is not supported in Availability Zone 'us-east-1e'"
- **Solution:** Implemented intelligent AZ filtering to exclude problematic zones
```hcl
data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "zone-name"
    values = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1f"]
  }
}
```

### 2. Complex Variable Validation
- **Challenge:** Ensuring proper input validation for 20+ variables
- **Solution:** Implemented comprehensive validation rules with custom error messages
- **Result:** Prevented configuration errors and improved user experience

### 3. Dynamic Security Group Rules
- **Challenge:** Creating flexible security groups based on boolean variables
- **Solution:** Used dynamic blocks with conditional logic
- **Result:** Achieved highly configurable security configurations

## Next Steps
- ✅ Complete clustered web server deployment
- ✅ Create architecture diagrams
- ✅ Write and publish blog post
- ✅ Complete comprehensive documentation
- ✅ Destroy all resources for cost optimization
- [ ] Prepare for Day 5 challenges
- [ ] Share learnings on social media
