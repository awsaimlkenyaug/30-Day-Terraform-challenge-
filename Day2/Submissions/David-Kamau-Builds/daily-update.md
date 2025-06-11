# Daily Update - Day 2

## Personal Information
- **Name:** David Washington Kamau Kibe
- **GitHub Username:** David-Kamau-Builds
- **Date:** 27th May 2025
- **Time of Completion:** 22:00 PM EAT

## Task Completed
[x] **Day 2: Setting Up Terraform**

### Tasks Accomplished:
1. **Reading**: Completed Chapter 1 of "Terraform: Up & Running" by Yevgeniy Brikman
2. **Hands-on Labs**: 
   - Set up your AWS account.
   - Install Terraform locally.
   - Install AWS CLI and configure it.
   - Install Visual Studio Code (VSCode) and add the AWS plugin.
   - Configure your VSCode to work with AWS.
3. **Blog Post**: Published "Step-by-Step Guide to Setting Up Terraform, AWS CLI, and Your AWS Environment."
4. **Social Media**: Posted progress on LinkedIn with required hashtags.
5. **Setup Activities**: Complete setup and configuration.

### Time Investment:
- **Reading**: 1 hour
- **Setup and Configuration**: 2 hours  
- **Blog Writing**: 1 hours
- **Total**: 4 hours

### Key Learnings:
- Chocolatey makes Windows software installation fast and scriptable with a single command.
- A valid AWS account is required before configuring CLI credentials.
- Terraform reads AWS credentials automatically from those files, so you don’t have to hardcode secrets.
- Using named AWS profiles (e.g., dev, test, prod) helps keep environments separate.

### Challenges Overcome:
- Terraform’s PATH issues were resolved by letting Chocolatey place the binary in the right location automatically.
- Remembering to save the IAM user’s secret key at creation time prevents losing credentials later.
- Making sure permissions are least-privilege (rather than using root or admin credentials) prevented overly broad access.


### Next Steps:
- Continue with Day 3: Deploying basic infrastructure with Terraform
- Practice using named profiles by configuring and switching between at least two profiles (e.g., dev and prod).
- Build reusable Terraform modules for common resources like VPCs, security groups, and subnets.

## Status: [x] COMPLETED
