# Day 12 Submission

## Personal Information
- **Name:** Denis Nganga
- **Date:** June 19, 2025
- **GitHub Username:** Denisganga

---

## 💡 Activity Summary: Zero-Downtime Deployment with Terraform

Today’s goal was to deploy a web application using Terraform with **zero downtime** by implementing a **blue/green deployment** strategy with AWS EC2, ALB, and target groups.

I created the infrastructure using:
- VPC with subnets
- Internet gateway and route tables
- Security group allowing HTTP and SSH
- Two EC2 instances: `BlueServer` and `GreenServer`
- ALB and target groups
- Listener forwarding to the Blue target group

---
## Social meda post
🔗 [View Post on LinkedIn](https://www.linkedin.com/posts/denis-nganga16_30daytfchallenge-30daytfchallenge-hug-activity-7343195475329626112--v6s?utm_source=share&utm_medium=member_desktop&rcm=ACoAAD6f18kBkqYbwrS6aVUAbqFNTkKbSj8rzzk)

## ❌ Challenge Faced: 502 Bad Gateway

After deploying everything, accessing the Load Balancer's DNS resulted in:
502 Bad Gateway

I discovered this error was due to:
- The Apache server (`httpd`) was **not installed**
- The `user_data` script silently failed
- Port 80 was open, but nothing was listening
- Also, the SSH key was not properly attached to the instance

---

## 🛠️ Steps Taken to Troubleshoot

- Verified Security Group rules (port 80 + 22 open ✅)
- Tried SSH, but received `Permission denied (publickey)`
- Realized instances were created without the expected key
- Logged into the EC2 and found `yum` and `httpd` missing
- Confirmed that `user_data` didn’t run correctly

---

## ✅ Lesson Learned

> **A 502 error doesn't always mean the server is down — it can mean the server is up, but not responding properly.**

This experience taught me:
- How to troubleshoot AWS ALB target groups
- The importance of validating `user_data` output
- That EC2 instances must be properly bootstrapped and reachable
- How small Terraform mistakes (like wrong SSH attachment) can block debugging



## 🚀 Final Thoughts

Even though this was one of the hardest debugging days I've had, it was also one of the most real and practical. This is what production feels like, and I'm proud to have pushed through most of it.

I’ll keep going 💪


