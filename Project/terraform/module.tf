
module "database" {
  source = "./modules/database"

  # variable
  db_name = "testdb"

}

module "instance" {
  source = "./modules/instance"

  # instance variable
  count = 2
  
  ami = var.ami
  type = "t2.micro"
  key_name = "vockey"
  vpc_security_group_ids = [module.security-group.instance_sg_id]
  subnet_ids = module.networking.public_subnet_ids

  # tags variable
  instance_tags = "${local.default_name}-servers"
}

module "load-balancer" {
  source = "./modules/load-balancer"


  # tags variable
  lb_tags = "${local.default_name}-web-loadbalancer"
  target_group_tags = "${local.default_name}-tgp"
  listener_tags = "${local.default_name}-listener"
}

module "networking" {
  source = "./modules/networking"

  # vpc variable
  network_address_space = "10.0.0.0/16"
  enable_dns_hostnames = true

  # subnet variable
  public_subnet_count = 2

  ## [public subnet, public subnet, private subnet]
  subnet_address_space = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  ## [public subnets, private subnet]
  map_public_ip_on_launch = [true, false]

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

  # vpc_id variable from networking module
  vpc_id = module.networking.vpc_id

  # instance security group variable
  instance_sg_name = "${local.default_name}_ssh_web_sg"
  instance_sg_description = "Allow SSH and HTTP access"

  instance_ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  instance_egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  # ELB security group variable
  elb_name = "${local.default_name}-elb-SG"
  elb_description = "Allow HTTP and HTTPS access"

  elb_ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  elb_egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  # tags variable
  elb_sg_tags  = "${local.default_name}-elb-SG"
  instance_sg_tags = "${local.default_name}-instance-SG"
}
