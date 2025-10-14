
resource "aws_vpc" "main" {
  cidr_block           = var.network_address_space
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "${var.vpc_tags}"
  }
}
