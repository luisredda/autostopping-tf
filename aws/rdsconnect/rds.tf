resource "aws_db_instance" "rds" {
  allocated_storage    = 10
  db_name              = "${var.name}db"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = var.dbuser
  password             = var.dbcred
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  vpc_security_group_ids = [ aws_security_group.allow_mysql.id ]
}