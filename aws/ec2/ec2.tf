resource "aws_instance" "ec2" {
  ami                     = var.ami
  instance_type           = "t3.micro"
  user_data = file("userdata.tpl")
  vpc_security_group_ids = [ aws_security_group.allow_http.id ]
  tags = {
    Name = "${var.name}-instance"
  }
}