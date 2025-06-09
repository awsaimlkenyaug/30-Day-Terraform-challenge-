# Day 7 Submission

## Personal Information
- **Name:** Denis Nganga
- **Date:** 2025-06-09
- **GitHub Username:** Denisganga

## Task Completion
- [x] Read Chapter 3 of "Terraform: Up & Running" (Pages 81-113)
- [x] Completed Hands-on Labs: Lab 08 (State Management) & Lab 09 (State Locking)
- [x] Configured state isolation using Terraform Workspaces
- [x] Configured state isolation using File Layouts (separate environment folders)
- [ ] Configured remote state storage and locking (planned next steps)
- [x] Wrote and published blog post
- [ ] Created social media post (to be done)

## Infrastructure Details

### Workspace-based State Isolation

Created isolated environments using Terraform Workspaces named dev, staging, and production. Each workspace maintains its own Terraform state allowing management of the same infrastructure code with different states and resources isolated per environment.

### File Layout-based State Isolation

Set up separate directories for dev, staging, and production environments, each containing its own Terraform configuration files and state files. This method isolates state by physical separation of environment code and configuration.

---

## Notes and Observations
- Workspaces enable multiple isolated states within a single codebase, reducing code duplication.
- File Layouts offer clearer separation by environment, helpful for customized configurations but can increase duplication.
- Choosing between them depends on team size, environment complexity, and workflow preferences.
- Next planned step: Implement remote state storage with locking (e.g., AWS S3 + DynamoDB).

## Blog Post

- **Title:** State Isolation: Layout vs Workspace  
- **Link:** [https://medium.com/@denisnganga16/state-isolation-layout-vs-workspace-665b835845c4](https://medium.com/@denisnganga16/state-isolation-layout-vs-workspace-665b835845c4)

## Social Media
- To be posted:  
  "🗂 Learned how to manage Terraform state effectively today. Crucial for consistent deployments. #30daytfchallenge #HUG #hashicorp #HUGYDE @chiche #IaC"

## Additional Resources Used
- Terraform official documentation on Workspaces
- "Terraform: Up & Running" by Yevgeniy Brikman, Chapter 3

## Time Spent
- Reading: 2 hours
- Hands-on Labs: 3 hours
- Blog Writing: 1 hour
- Total: 6 hours

## Repository Structure
Day7/
└── Submissions/
└── Denisganga/
├── Denisgangasubmission.md
└── terraform-state-isolation-demo/
├── dev/
├── staging/
├── production/
├── example-dev.txt
├── example-staging.txt
├── main.tf
└── terraform.tfstate.d/