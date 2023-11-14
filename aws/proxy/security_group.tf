resource "aws_security_group" "sgforproxy" {
  name        = "${var.name}-instance-allow_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = var.vpc

  ingress {
    description      = "Open HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0" ]
  }
  ingress {
    description      = "Open SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0" ]
  }

  # Ephemeral ports
  ingress {
    description      = "Ephemeral ports for RDS connect"
    from_port        = 1024
    to_port          = 65535
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
    Name = "${var.name}-allow_http"
  }
}