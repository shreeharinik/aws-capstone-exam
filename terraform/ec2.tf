resource "aws_instance" "web" {
  count         = 2
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public[count.index].id
  key_name      = var.key_name
  security_groups = [aws_security_group.web_sg.id]
}
