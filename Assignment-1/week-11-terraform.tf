
variable "access_key" {}
variable "secret_key" {}
variable "token" {}
variable "ami" {}

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  token      = var.token
  region     = "us-east-1"
}

resource "aws_vpc" "testVPC" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "Public1" {
  vpc_id            = aws_vpc.testVPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1b"
}

resource "aws_security_group" "AllowSSHandWeb" {
  name        = "AllowSSHandWeb"
  description = "Allow incoming SSH and HTTP traffic to EC2 instance"
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

resource "aws_instance" "instance1" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = "vockey"
  vpc_security_group_ids = [aws_security_group.AllowSSHandWeb.id]
  subnet_id              = aws_subnet.Public1.id

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }

  tags = {
    Name = "tfTest"
  }
}

output "aws_instance_public_dns" {
  value = aws_instance.instance1.public_dns
}
