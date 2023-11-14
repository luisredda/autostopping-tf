resource "aws_security_group" "allow_mysql" {
  name        = "${var.name}-rds-allow_mysql"
  description = "Allow MySQL inbound traffic"
  vpc_id      = var.vpc

  ingress {
    description      = "Open MySQL"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0" ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.name}-allow_mysql"
  }
}