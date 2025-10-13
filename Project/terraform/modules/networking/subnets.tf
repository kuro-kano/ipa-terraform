resource "aws_subnet" "public" {
  count = var.subnet_count

  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_address_space[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = var.public_subnet_tags[count.index + 1]
  }
}
