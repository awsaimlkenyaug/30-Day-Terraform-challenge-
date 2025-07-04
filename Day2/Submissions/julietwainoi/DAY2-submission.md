## Day 2 Submission

### Personal Information
- **Name:** Juliet Wanjiku
- **Date:** 2025-05-27
- **GitHub Username:** julietwainoi

---

### Task Completion
- [x] Read Chapter 2 of "Terraform: Up & Running"
- [x] Completed Required Hands-on Labs
- [x] Deployed Single Server
- [x] Deployed Web Server
- [x] Created Infrastructure Diagrams

---

### Infrastructure Details

#### Single Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:**
  - Basic EC2 instance
  - Tagged with Name = "SingleServer"

#### Web Server Deployment
- **Region:** us-east-1
- **Instance Type:** t2.micro
- **Key Features:**
  - EC2 with Apache Web Server
  - Displays simple HTML page
  - Uses `user_data` script for setup

---

### Infrastructure Diagrams
See images in the `architecture/` folder:
- `single-server.png`
- `web-server.png`

---

### Blog Post
- **Title:** My Day 2: Deploying EC2 with Terraform
- **Link:** [https://myblog.com/day2-terraform](https://julietwainoi.github.io/blog2.html)

---

### Social Media
- **Platform:** LinkedIn
- **Post Link:** [https://linkedin.com/in/my-post-day2](https://www.linkedin.com/in/juliet-wainoi/)

---

### Notes and Observations
- Learned how to use `user_data` for setup automation
- Faced issue with wrong AMI ID — fixed by choosing correct region-specific AMI
- Understood importance of resource tagging and infrastructure planning

---

### Additional Resources Used
- AWS Docs: EC2 AMI Reference
- Terraform Registry

---

### Time Spent
- **Reading:** 1.5 hours
- **Infrastructure Deployment:** 1 hour
- **Diagram Creation:** 0.5 hours
- **Blog Writing:** 1 hour
- **Total:** 4 hours

Day2/
└── Submissions/
    └── julietwainoi/
        ├── architecture/
        │   ├── single-server.png
        │   └── web-server.png
        ├── terraform/
        │   ├── single-server/
        │   │   └── main.tf
        │   └── web-server/
        │       └── main.tf
        └── DAY2-submission.md
``` 
