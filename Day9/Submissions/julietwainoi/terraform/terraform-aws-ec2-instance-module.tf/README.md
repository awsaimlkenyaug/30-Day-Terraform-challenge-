## Terraform EC2 Instance Module

### Usage

```hcl
module "ec2" {
  source  = "git::https://github.com/YOUR-USERNAME/terraform-aws-ec2-instance-module.git?ref=v1.0.0"
  ami     = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags = {
    Name = "MyInstance"
    Env  = "dev"
  }
}

after all this :

 -commit & push this to GitHub, and tag your releases:
 -git tag v1.0.0
 -git push origin v1.0.0