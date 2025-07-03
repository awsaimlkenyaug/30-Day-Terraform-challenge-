# Day 20: Workflow for Deploying Application Code

## 🔁 Deployment Workflow
1. Used Git and GitHub for version control.
2. Ran the Terraform config locally using `terraform apply`.
3. Created a new branch `day20-deploying-app-code` for the task.
4. Pushed code to GitHub and connected Terraform Cloud to the branch.
5. Added sensitive AWS credentials securely as workspace variables.
6. Triggered a plan and apply from Terraform Cloud.
7. Confirmed that the S3 bucket was successfully created.

## 🔐 Securing Variables
- Set `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as sensitive variables in the Terraform Cloud workspace.

## 📦 Private Module Registry (Optional)
- (If done) Created a simple reusable S3 bucket module and added it to Terraform Cloud's private registry.

## 📸 Screenshots
- See `architecture/` folder for proof of successful deployment.

## ✅ Status
- [x] Deployment run successful
- [x] Variables secured in Terraform Cloud
- [x] Code versioned in GitHub
