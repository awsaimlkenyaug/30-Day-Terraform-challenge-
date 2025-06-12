# Single Server Architecture on AWS with Terraform

This project sets up a simple single-server architecture on AWS using Terraform. It includes:

* A Virtual Private Cloud (VPC)
* A public subnet
* An internet gateway
* A route table
* A security group for SSH and HTTP
* A single Amazon EC2 instance with a public IP

## 📁 File Structure

```
.
├── main.tf               # Main infrastructure configuration
├── variables.tf          # Input variable definitions
├── outputs.tf            # Outputs like public IP and DNS
├── terraform.tfvars      # Custom variable values
├── /images               # architecture diagram and other relevant images
└── README.md             # Documentation
```

## 🚀 Quick Start

### 1. Prerequisites

* [Terraform installed](https://www.terraform.io/downloads.html)
* [AWS CLI installed](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
* An AWS account with permissions to create EC2, VPC, and networking resources
* Must have configured AWS CLI with your AWS Account. If not please go through my step-by-step tutorial here 👉(https://medium.com/@davidwashingtonkamau/step-by-step-guide-to-setting-up-terraform-aws-cli-and-your-aws-environment-79b08136fb78)

### 2. Configure AWS CLI

```bash
aws configure --profile test
```

### 3. Create EC2 Key Pair via AWS CLI

```bash
aws ec2 create-key-pair \
  --key-name my-cli-key \
  --key-type rsa \
  --query 'KeyMaterial' \
  --output text > my-cli-key.pem
chmod 400 my-cli-key.pem
```

Update `terraform.tfvars`:

```hcl
key_name = "my-cli-key"
allowed_ip = "YOUR.PUBLIC.IP.ADDRESS/32"
```

### 4. Initialize and Deploy

```bash
terraform init
terraform plan
terraform apply
```

Type `yes` to confirm when prompted.

### 5. Access Your EC2 Instance

```bash
ssh -i my-cli-key.pem ec2-user@<public-ip-output>
```

Replace `ec2-user` with `ubuntu` if you're using an Ubuntu AMI.

## 📄 Outputs

After deployment, Terraform will output:

* `instance_public_ip`
* `instance_public_dns`

You can use either to SSH into the EC2 instance or access a web server if installed.

## 🧹 Cleanup

To delete all resources:

```bash
terraform destroy
```

## 📌 Notes

* Default AMI ID used is for Amazon Linux 2 in `us-east-1`. Update it if needed.
* Use `t2.micro` to stay within AWS Free Tier.

## 🔐 Security

* Your `.pem` file should never be committed to version control.
* Use `chmod 400` to protect the key.
* Restrict SSH access to your IP only in `allowed_ip`.

---

Feel free to customize or extend this to add RDS, S3, CloudFront, or private subnets.
