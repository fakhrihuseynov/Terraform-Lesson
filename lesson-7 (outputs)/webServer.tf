# This resource will create simple Web-Server in AWS
# 
# My Terraform
# Build WebServer in AWS
# Region eu-central-1
# Made by Fakhri Huseynov

provider "aws" {
  region = "eu-central-1"
}

resource  "aws_eip" "myPip" {
    instance = aws_instance.my-webserver.id
  }

# Deploy Amazon Linux WebServer
resource "aws_instance" "my-webserver" {
  ami                    = "ami-03a71cec707bfc3d7"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my-webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Fakhri",
    l_name = "Huseynov"
    names  = ["Turan", "Asmar", "Zaur", "Gular", "Nahid",]
  })
  tags = {
    Name  = "amazonWebServer"
    Owner = "Fakhri Huseynov"
  }


  lifecycle {

    # 1. This command will prevent to destory any resources created before during updates
    # prevent_destroy = true

    # 2. This command will prevent terraform apply if we will change or update any values below (ami), (user_data)
    # ignore_changes = [
    #   "ami", "user_data"
    # ]

    # 3. This command will create any resource before destroying existing one
    create_before_destroy = true

  } 
}

# Deploy Network Securty Group
resource "aws_security_group" "my-webserver" {
  name        = "webServer_securityGroup"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "nsg_webserver"
    Owner = "Fakhri Huseynov"
  }
}