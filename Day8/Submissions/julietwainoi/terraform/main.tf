provider "aws" {
  region = "us-west-2"
}

module "web_server" {
  source        = "./modules/ec2-instance"
  ami           = "ami-0953476d60561c955"
  instance_type = "t2.micro"
  tags = {
    Name        = "Day8WebServer"
    Environment = "dev"
  }
}

output "web_server_ip" {
  value = module.web_server.public_ip
}
