
resource "aws_instance" "Server" {
  count = 2

  ami = var.ami
  instance_type = var.type
  key_name = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id = var.subnet_ids[count.index].id

  tags = {
    Name = var.instance_tags
  }
}