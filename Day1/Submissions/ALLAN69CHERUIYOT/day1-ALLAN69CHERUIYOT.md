# Day 1 Submission

## Personal Information
- **Name:** ALLAN CHERUIYOT
- **Date:** 2025-06-26 17:00 EAT
- **GitHub Username:** ALLAN69CHERUIYOT

## Task Completion
- [✅] Read Chapter 1 of "Terraform: Up & Running"
- [✅] Completed Required Hands-on Labs
- [✅] Set up AWS Account
- [✅] Installed Terraform
- [✅] Installed and Configured AWS CLI
- [✅ ] Installed VSCode with AWS Plugin
- [✅] Configured VSCode for AWS

## Blog Post
- **Title:** "What is Infrastructure as Code (IaC) and Why It's Transforming DevOps"
- **Link:** https://allan-blog.hashnode.dev/what-is-iac-and-its-benefits

## Social Media
- **Platform:**linkedin
- **Post Link:** https://www.linkedin.com/posts/allan-cheruiyot-730896331_30daytfchallenge-hug-hashicorp-activity-7333119299034697728-nAzq?utm_source=share&utm_medium=member_desktop&rcm=ACoAAFOaNZQBPsFm1zkiP9oxzdKTVE9IbqnDYZU

## Notes and Observations
Key Learnings:
Immutability is Gold: Treat your infrastructure like code – once deployed, don't manually modify it. If a change is needed, update the IaC definition and redeploy. This ensures consistency and prevents "configuration drift."
Version Control is Non-Negotiable: Always store your IaC in Git (or similar). This provides a single source of truth, change history, collaboration features, and easy rollbacks.
Plan for State Management: Understand how your IaC tool manages state (e.g., Terraform's state file). Protect it, back it up, and use remote state for team collaboration.
Modularization Pays Off: Break down complex infrastructure into smaller, reusable modules (e.g., a VPC module, a database module). This promotes reusability, reduces redundancy, and simplifies maintenance.
Embrace Testing: Just like application code, IaC needs testing (e.g., linting, static analysis, integration tests). This catches errors early and ensures desired behavior.
Drill Down into Provider Details: Each cloud provider (AWS, Azure, GCP) or platform has its nuances. Deeply understand the resources and their properties within your chosen IaC tool.
Challenges Faced:
State Management Complexities:

Challenge: Corrupted state files, conflicts when multiple people modify infrastructure, or accidentally deleting state.
Overcame: Always use remote state storage (e.g., S3 for Terraform), enable locking to prevent concurrent writes, and implement robust backup strategies for state files. Educate the team on state file best practices.
Learning Curve of New Tools/Syntax:

Challenge: Picking up HCL (Terraform), CloudFormation YAML/JSON, or Ansible YAML can be daunting initially, especially for complex resources.
Overcame: Start with small, manageable projects. Leverage official documentation, community forums, and online tutorials. Experiment in isolated "sandbox" environments. Focus on understanding core concepts before diving into advanced features.
Debugging & Error Resolution:

Challenge: Vague error messages from IaC tools or cloud APIs, especially during initial deployments.
Overcame: Increase verbosity/logging levels of the IaC tool. Carefully read error messages and consult documentation for specific error codes. Break down deployments into smaller steps to isolate issues. Use terraform plan extensively before terraform apply.
Managing Secrets and Sensitive Data:

Challenge: Hardcoding API keys, passwords, or other sensitive information directly into IaC files, posing a security risk.
Overcame: Integrate with dedicated secret management services (e.g., AWS Secrets Manager, Azure Key Vault, HashiCorp Vault). Use environment variables or secure input methods for non-production environments. Never commit secrets to version control.
Dealing with Existing "Legacy" Infrastructure:

Challenge: Importing and managing existing infrastructure that wasn't provisioned with IaC, leading to manual toil or inconsistencies.
Overcame: Utilize import functionalities of IaC tools (e.g., terraform import). Prioritize critical existing components for IaC adoption, then gradually bring others under management. Recognize that some older, less critical infrastructure might remain outside IaC initially.
Ensuring Idempotency:

Challenge: IaC scripts sometimes not being truly idempotent, meaning running them multiple times results in different outcomes or errors.
Overcame: Understand the idempotent nature of the chosen IaC tool's resources. For custom scripts or provisioning, carefully design them to check for existing states before attempting actions. Thorough testing helps identify non-idempotent behavior.

## Additional Resources Used
Youtube videos.

## Time Spent
- Reading: 3hours.
- Setup and Configuration: 2 hours
- Blog Writing: 1 hour.
- Total: 6 hours. 



