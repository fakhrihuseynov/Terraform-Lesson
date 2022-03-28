output "webserver_instance_id" {
  value = aws_instance.my-webserver.id
  description = "This is webapp resource id outputs"
}

output "webserver_public_ip" {
  value = aws_eip.myPip.public_ip
  description = "This is elastic public ip address output"
}

output "nsg_id" {
    value = aws_security_group.my-webserver.id
}