# Weekly Submission - Week [Number]

## ⚠️ IMPORTANT: Branch Selection
- This PR must target the appropriate week branch (`week1`, `week2`, `week3`, or `week4`)
- PRs to `main` branch will be automatically rejected
- Select the week branch that matches your submission week
- You can submit multiple PRs to the same week branch if needed

## Participant Information
- **GitHub Username:** [Your GitHub Username]
- **Week Number:** [1-4]
- **Target Branch:** week[1-4]
- **Days Completed:** [List of days completed this week, e.g., Days 1-7]
- **Check-in Attendance:** [Yes/No - Did you attend this week's check-in?]

## Submissions Overview

### [Day X]
- **Topic:** [Topic of the day]
- **Key Learnings:**
  - [Brief bullet points of what you learned]
- **Resources Created:**
  - [List of infrastructure resources created]
  - [Include cost estimation if applicable]
- **File Structure:**
  ```
  DayX/
  ├── main.tf
  ├── variables.tf
  ├── outputs.tf
  ├── terraform.tfvars
  └── README.md
  ```
- **Testing Completed:**
  - [ ] `terraform init` successful
  - [ ] `terraform plan` shows expected changes
  - [ ] `terraform apply` completed without errors
  - [ ] `terraform destroy` cleaned up all resources
- **Blog Post:** [Link to your blog post]
- **Social Media:** [Link to your social media post with #AWSAIMLKenyaTerraformChallenge]

### [Day Y]
- **Topic:** [Topic of the day]
- **Key Learnings:**
  - [Brief bullet points of what you learned]
- **Resources Created:**
  - [List of infrastructure resources created]
- **Blog Post:** [Link to your blog post]
- **Social Media:** [Link to your social media post]

[Repeat for each day in this week's submission]

## Weekly Check-in Details
- **Date:** [YYYY-MM-DD]
- **Time:** 6:00 PM EAT
- **Meeting Link:** [Will be shared in WhatsApp group]
- **Preparation Completed:**
  - [ ] Reviewed this week's tasks and progress
  - [ ] Prepared questions for discussion
  - [ ] Updated progress tracking files
  - [ ] Reviewed other participants' PRs
  - [ ] Ready to demo any interesting solutions

## Code Quality Requirements
- **Security:**
  - [ ] No hardcoded credentials
  - [ ] Using variables for sensitive data
  - [ ] Implemented proper IAM roles/policies
  - [ ] Security groups properly configured
- **Best Practices:**
  - [ ] Code is properly formatted (`terraform fmt`)
  - [ ] Code passes validation (`terraform validate`)
  - [ ] Resources have proper tags
  - [ ] Using data sources where appropriate
  - [ ] Implemented state management
  - [ ] Added necessary providers and versions

## Points Breakdown
1. **Base Points per Day (10 points each)**
   - PR Submission: 10 points
   - Number of Days: [X] × 10 = [Total] points

2. **Code Quality (max 5 points per day)**
   - Clean commits (1 point per commit, max 5)
   - PR Size:
     * 1-5 files: 3 points
     * 6-10 files: 2 points
     * 11+ files: 1 point

3. **Documentation (2 points each)**
   - README.md: 2 points
   - Blog post: 2 points
   - Proper comments: 2 points

4. **Community Engagement**
   - Check-in attendance: 5 points
   - PR comments/reviews: 1 point each (max 5)
   - Helping others: 1 point each (max 5)

Total Expected Points: [Calculate your total based on above]

## Checklist
- [ ] I have completed all tasks for the days included
- [ ] Each day's work is properly documented
- [ ] All Terraform code follows required structure
- [ ] Security best practices implemented
- [ ] State management configured
- [ ] All resources have proper tagging
- [ ] Blog posts published and linked
- [ ] Social media posts made with #AWSAIMLKenyaTerraformChallenge
- [ ] Attended weekly check-in or notified about absence
- [ ] Reviewed and commented on other participants' PRs
- [ ] All code tested (init, plan, apply, destroy)
- [ ] No sensitive data in commits

## Additional Notes
[Any additional information, challenges faced, or feedback you'd like to share]

## Terraform Validation Results
```hcl
# Paste your terraform validate output here
```

## Cost Estimation
```hcl
# Paste your terraform plan cost estimation here (if applicable)
```
