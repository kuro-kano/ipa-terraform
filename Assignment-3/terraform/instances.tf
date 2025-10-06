
resource "aws_instance" "Server" {
  count = 2

  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh_web.id]
  subnet_id              = aws_subnet.public[count.index].id

  tags = {
    Name    = "${local.server_name}-${count.index + 1}"
    itclass = "ipa25"
    week    = "13"
  }
}