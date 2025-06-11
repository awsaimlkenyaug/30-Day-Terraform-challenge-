# Simple Web Server Application on AWS with Terraform

This project deploys a simple Apache-based web server on AWS using Terraform. It provisions a publicly accessible EC2 instance in a VPC and installs a custom HTML web page on startup.

---

## 📦 Project Structure

```
web-server-app/
├── main.tf             # Infrastructure configuration
├── variables.tf        # Input variables
├── terraform.tfvars    # Variable values
├── outputs.tf          # Output values
├── provider.tf         # AWS provider configuration
├── /images             # architecture diagram and other relevant images
└── README.md           # Documentation

```

---

## 🏗️ Architecture

![Web Server Application Architecture](./images/web-server-architecture.png)

---


## 🚀 Features

* Creates a VPC with a public subnet in a single AZ
* Deploys an EC2 instance with a public IP
* Installs and starts Apache via `user_data`
* Serves a custom web page
* Uses a key pair for SSH access
* Configures security group for HTTP and SSH

---

## 🛠️ Prerequisites

* [Terraform](https://www.terraform.io/downloads)
* [AWS CLI](https://aws.amazon.com/cli/) configured (`aws configure`)
* Existing EC2 Key Pair (or generate one)

To generate a key pair via CLI:

```bash
aws ec2 create-key-pair --key-name my-cli-key --query 'KeyMaterial' --output text > my-cli-key.pem
chmod 400 my-cli-key.pem
```

Update your `terraform.tfvars`:

```hcl
key_name        = "my-cli-key"
allowed_ip      = "YOUR.PUBLIC.IP.ADDRESS/32"
environment     = "dev"
```

---

## 🧪 Usage

```bash
terraform init
terraform apply
```

When complete, Terraform will output the EC2 instance public IP and web URL. Open it in your browser:

```
http://<public-dns>
```

---

## 🔒 Security Notes

* Only your IP is allowed for SSH (port 22)
* HTTP (port 80) is open to the internet

---

## 🧹 Cleanup

To destroy all resources:

```bash
terraform destroy
```

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).