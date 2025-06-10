# Day 9 Submission

## Personal Information
- **Name:** [Andrew Muntet]
- **Date:** [6/06/2025]
- **GitHub Username:** [Andrew-glitch-Ux]

## Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

## Infrastructure Details

###  Environment-Specific S3 Bucket Deployment (via Workspaces)
- **Region:** eu-north-1
- **Instance Type:** t3.micro
- **Key Features:** Provisioned EC2 instance in public subnet with SSH and HTTP access; used workspace-aware naming

### Modular Multi-Environment Web Server Deployment
- **Region:** eu-north-1
- **Instance Type:** t3.micro
- **Key Features:** Created reusable Terraform modules for VPC, Subnet, EC2, and SG; Deployed across dev, staging, and prod using workspaces

## Infrastructure Diagrams
Please place your infrastructure diagrams in the `architecture` folder with the following files:
- `single-server.png` - Diagram for the single server deployment
- `web-server.png` - Diagram for the web server deployment

## Blog Post
- **Title:** Managing Multi-Environment Deployments with Terraform Workspaces
- **Link:** [URL to your blog post]

## Social Media
- **Platform:** LinkedIn
- **Post Link:** [URL to your social media post]

## Notes and Observations
Today I completed Lab 10 on Terraform Workspaces. I learned how to isolate environments using `terraform.workspace`, keeping each state file separate while using a shared codebase. I used modules for reusability and deployed VPC, Subnet, Security Group, and EC2 instance in dev, staging, and prod. The architecture diagram clearly shows each environment under the same AWS account.

## Additional Resources Used
- Terraform Docs: https://developer.hashicorp.com/terraform/language/state/workspaces
- AWS EC2 Documentation
- ChatGPT guidance

## Time Spent
- Reading: 30 mins
- Infrastructure Deployment: 1 hour
- Diagram Creation: 30 mins
- Blog Writing: 30 mins
- Total: 2.5 hours

## Repository Structure
```
Day9/
  Submissions/
	Andrew-glitch-Ux/
	  architecture/
		lab10-architecture-diagram.drawio.png
		lab11.drawio.png
	  lab10/
		.terraform/
		  providers/
			LICENSE.txt
			terraform-provider-aws_v5.99.1_x5.exe
		terraform.tfstate.d/
		  lab10/
			terraform.tfstate
			terraform.tfstate.backup
		  staging/
			terraform.tfstate
			terraform.tfstate.backup
		.terraform.lock.hcl
		main.tf
		output.tf
		variables.tf
	  lab11/
		envs/
		  dev/
			terraform/
			  modules/
			  module.json
			  providers/
			  LICENSE.txt
			  terraform-provider-aws_v5.99.1_x5.exe
			.terraform.lock.hcl
			main.tf
			outputs.tf
			terraform.tfstate
			terraform.tfstate.backup
			terraform.tfvars
			variables.tf
		  prod/
			[same structure as dev]
		  staging/
			[same structure as dev]
		modules/
		  web server/
			main.tf
			outputs.tf
			variables.tf
      daily update.md
	  submissionday9.md
	  README.md
	  submission_template.md
  README.md
  tasks.md
```

