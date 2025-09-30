
variable "access_key" {}
variable "secret_key" {}
variable "token" {}
variable "key_name" {}

variable "region" { default = "us-east-1" }
variable "network_address_space" { default = "10.0.0.0/16" }
variable "subnet1_address_space" { default = "10.0.1.0/24" }


provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.token
  region     = var.region
}

data "aws_ami" "aws-linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_vpc" "testVPC" {
  cidr_block = var.network_address_space
  enable_dns_hostnames = true

  tags = {
    Name = "testVPC"
  }
}

resource "aws_subnet" "Public1" {
  vpc_id            = aws_vpc.testVPC.id
  cidr_block        = var.subnet1_address_space
  availability_zone = "us-east-1b"

  tags = {
    Name = "Public1"
  }
}

resource "aws_internet_gateway" "testIgw" {
  vpc_id = aws_vpc.testVPC.id

  tags = {
    Name = "testIgw"
  }
}

resource "aws_route_table" "publicRouter" {
  vpc_id = aws_vpc.testVPC.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.testIgw.id
    }

  tags = {
    Name = "publicRouter"
  }
}

resource "aws_route_table_association" "rt-pubsub1" {
  subnet_id      = aws_subnet.Public1.id
  route_table_id = aws_route_table.publicRouter.id
}

resource "aws_security_group" "allow_ssh_web" {
  name        = "npaWk12_demo"
  description = "Allow ssh and web access"
  vpc_id      = aws_vpc.testVPC.id

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
}

resource "aws_instance" "Server1" {
  ami                    = data.aws_ami.aws-linux.id
  instance_type          = "t2.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh_web.id]
  subnet_id              = aws_subnet.Public1.id

  tags = {
    Name = "Server1"
  }
}


output "aws_instance_public_ip" {
  value = aws_instance.Server1.public_ip
}