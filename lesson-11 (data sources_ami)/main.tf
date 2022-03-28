# You can find aws data sources on this link: https://registry.terraform.io/providers/hashicorp/aws/latest/docs
# ----------------------------------
# My Terraform
#
# Find latest AMI id of:
#     - Ubuntu 20.04
#     - Amazon Linux 2
#     - Windows Server 2016 Base
#
# Made by Fakhri Huseynov
# ----------------------------------

provider "aws" {
  region = "eu-central-1"
}


resource "aws_instance" "latest_windows" {
  ami           = data.aws_ami.latest_windows_2019.id
  instance_type = "t3.micro"
  tags = {
    "Name" = "windows2019"
  }
  key_name = "terraform_key_32"
  get_password_data = true
}


data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["137112412989"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "latest_windows_2019" {
  owners      = ["801119661308"]
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
}




#----------Outputs for Ubuntu 20.04-------------------

output "latest_ubuntu_id" {
  value = data.aws_ami.latest_ubuntu.id
}
output "latest_ubuntu_name" {
  value = data.aws_ami.latest_ubuntu.name
}

#----------Outputs for Amazon Linux 2-----------------
output "latest_amazon_linux_id" {
  value = data.aws_ami.latest_amazon_linux.id
}
output "latest_amazon_linux_name" {
  value = data.aws_ami.latest_amazon_linux.name
}

#----------Outputs for Windows 2019-------------------
output "latest_windows_2019_id" {
  value = data.aws_ami.latest_windows_2019.id
}
output "latest_windows_2019_name" {
  value = data.aws_ami.latest_windows_2019.name
}
