# This resource will create simple Web-Server in AWS
# 
# My Terraform
# Build WebServer in AWS
# Region eu-central-1
# Made by Fakhri Huseynov

provider "aws" {
  region = "eu-central-1"
}


# Deploy Amazon Linux WebServer
resource "aws_instance" "my-webserver" {
  ami                    = "ami-03a71cec707bfc3d7"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my-webserver.id]
  tags = {
    Name  = "amazonWebServer"
    Owner = "Fakhri Huseynov"
  }
  user_data = <<EOF
#!/bin/bash
yum -y update
yum -y install httpd
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
echo "<h2>WebServer with IP: $myip</h2><br>Build by Fakhri Huseynov! New feature" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on
EOF
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
