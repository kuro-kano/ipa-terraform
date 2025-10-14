
resource "aws_subnet" "public" {
  count = var.public_subnet_count

  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_address_space[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch[0]

  tags = {
    Name = var.public_subnet_tags[count.index]
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_address_space[2]
  availability_zone = var.availability_zones[2]
  map_public_ip_on_launch = var.map_public_ip_on_launch[1]

  tags = {
    Name = var.private_subnet_tags
  }
}