# 🌍 Terraform Challenge – Day 2 Update

## 🔧 1. Set Up Environment

- 🛠 **Tools Used:**  
  - Visual Studio Code (VS Code)  
  - Terraform CLI  

- 📁 **Project Structure:**  
  - Created a new folder: `Terraform project`  
  - Added a main configuration file: `main.tf`

---

## 🧾 2. Wrote Terraform Configuration

### **File: `main.tf`**

```hcl
provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c1ac8a41498c1a9c"           # Ubuntu AMI in eu-north-1
  instance_type = "t3.micro"                        # Supported instance type
  subnet_id     = "subnet-0b313224ecb43decc"        # Custom subnet ID
}
