
module "database" {
  source = "./modules/database"

  # variable

  # tags
  tags = {
    Name = "testdb"
  }
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

  # tags variable
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
