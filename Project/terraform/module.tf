
module "database" {
  source = "./modules/database"

  # variable
  db_name = "testdb"

}

module "instance" {
  source = "./modules/instance"

  # tags variable
  instance_tags = "${local.default_name}-servers"
}

module "load-balancer" {
  source = "./modules/load-balancer"

  # tags variable
  elb_tags = "${local.default_name}-web-loadbalancer"
  listener_tags = "${local.default_name}-listener"
}

module "networking" {
  source = "./modules/networking"

  # vpc variable
  network_address_space = "10.0.0.0/16"
  enable_dns_hostnames = true

  subnet_count = 2
  subnet_address_space = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
  map_public_ip_on_launch = true

  # route table variable
  rt_cidr_block = "0.0.0.0/0"

  # tags variable
  vpc_tags = "${local.default_name}-VPC"

  igw_tags = "${local.default_name}-testIGW"

  public_subnet_tags = [
    "${local.default_name}-publicsubnet1",
    "${local.default_name}-publicsubnet2"
  ]
  private_subnet_tags = "${local.default_name}-privatesubnet1"

  public_route_table_tags = "${local.default_name}-publicRouteTable"
  private_route_table_tags = "${local.default_name}-privateRouteTable"

}

module "security-group" {
  source = "./modules/security-group"


  # tags variable
  elb_sg_tags  = "${local.default_name}-elb-SG"
  instance_sg_tags = "${local.default_name}-instance-SG"
}
