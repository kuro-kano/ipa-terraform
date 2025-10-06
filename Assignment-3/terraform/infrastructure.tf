
resource "aws_vpc" "main_VPC" {
  cidr_block           = var.network_address_space
  enable_dns_hostnames = true

  tags = {
    Name = "${local.name_prefix}_VPC"
  }
}

resource "aws_subnet" "public" {
  count = 2

  vpc_id                  = aws_vpc.main_VPC.id
  cidr_block              = var.subnet_address_space[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]  # เพิ่ม data.
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name_prefix}_public_subnet_${count.index + 1}"
  }
}

resource "aws_internet_gateway" "main_Igw" {
  vpc_id = aws_vpc.main_VPC.id

  tags = {
    Name = "itKMITL_IGW"
  }
}

resource "aws_route_table" "Public_Router" {
  vpc_id = aws_vpc.main_VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_Igw.id
  }

  tags = {
    Name = "${local.name_prefix}_Public_Router"
  }
}

resource "aws_route_table_association" "rt-pubsub" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.Public_Router.id
}

resource "aws_security_group" "allow_ssh_web" {
  name        = "${local.name_prefix}_ssh_web_sg"
  description = "Allow ssh and web access"
  vpc_id      = aws_vpc.main_VPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.name_prefix}_sg"
  }
}
