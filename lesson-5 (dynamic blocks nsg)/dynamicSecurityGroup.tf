# This resource will create simple Web-Server in AWS
# 
# My Terraform
# Build WebServer in AWS
# Region eu-central-1
# Made by Fakhri Huseynov

provider "aws" {
  region = "eu-central-1"
}


# Deploy Network Securty Group
resource "aws_security_group" "my-webserver" {
  name = "dynamicSecurityGroup"
  dynamic "ingress" {
    for_each = ["80", "443", "8080", "1541", "9092"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.10.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "dynamicSecurityGroup"
    Owner = "Fakhri Huseynov"
  }
}
