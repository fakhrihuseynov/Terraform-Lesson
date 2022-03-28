resource "aws_instance" "myWindows" {
  ami           = "ami-09d416ef29471299a"
  instance_type = "t3.micro"
  count = 1
  tags = {
    Name = "myWindows"
  }
}
resource "aws_instance" "myUbuntu" {
  ami           = "ami-042ad9eec03638628"
  instance_type = "t3.micro"
  count = 1
  tags = {
    Name = "myUbuntu"
  }
}