resource "aws_db_subnet_group" "db" {
  subnet_ids = aws_subnet.private[*].id
}

resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  db_name              = "streamline"
  username             = "admin"
  password             = "Admin12345!"
  db_subnet_group_name = aws_db_subnet_group.db.name
  skip_final_snapshot  = true
}
