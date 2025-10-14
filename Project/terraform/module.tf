
module "database" {
  source = "./modules/database"

  # Database subnet group variable
  private_subnet_id = module.networking.private_subnet_ids

  # Database variable
  allocated_storage = 10
  db_name           = "testdb"
  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  identifier        = "${local.default_name}-db-instance"

  username = "admin"
  password = "password"

  group_name          = "default.mysql8.0"
  skip_final_snapshot = true

}

module "instance" {
  source = "./modules/instance"

  # instance variable
  instance_count = 2

  ami                    = var.ami
  type                   = "t2.micro"
  key_name               = "vockey"
  vpc_security_group_ids = [module.security-group.instance_sg_id]
  subnet_ids             = module.networking.public_subnet_ids

  # tags variable
  instance_tags = "${local.default_name}-servers"
}

module "load-balancer" {
  source = "./modules/load-balancer"

  # variable
  vpc_id       = module.networking.vpc_id
  instance_ids = module.instance.instance_ids

  # load balancer variable
  lb_name            = "server-loadbalancer"
  lb_internal        = false
  lb_type            = "application"
  lb_security_groups = [module.security-group.lb_sg_id]
  lb_subnets         = module.networking.public_subnet_ids

  lb_deletion_protection = false

  # target group variable
  tg_name     = "server-tg"
  tg_port     = 80
  tg_protocol = "HTTP"

  ## health check variable
  hc_enabled   = true
  hc_healthy   = 2
  hc_unhealthy = 2
  hc_timeout   = 5
  hc_protocol  = "HTTP"
  hc_path      = "/"
  hc_interval  = 30
  hc_matcher   = "200"

  ## target attachment variable

  # listener variable
  listener_port     = 80
  listener_protocol = "HTTP"
  ## default_action
  default_action_type = "forward"

  # tags variable
  lb_tags           = "${local.default_name}-web-loadbalancer"
  target_group_tags = "${local.default_name}-tgp"
  listener_tags     = "${local.default_name}-listener"
}

module "networking" {
  source = "./modules/networking"

  # vpc variable
  network_address_space = "10.0.0.0/16"
  enable_dns_hostnames  = true

  # subnet variable
  public_subnet_count = 2

  ## [public subnet, public subnet, private subnet]
  subnet_address_space = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c"]
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

  public_route_table_tags  = "${local.default_name}-publicRouteTable"
  private_route_table_tags = "${local.default_name}-privateRouteTable"

}

module "security-group" {
  source = "./modules/security-group"

  # vpc_id variable from networking module
  vpc_id = module.networking.vpc_id

  # instance security group variable
  instance_sg_name        = "${local.default_name}_ssh_web_sg"
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

  # LB security group variable
  lb_name        = "${local.default_name}-lb-SG"
  lb_description = "Allow HTTP and HTTPS access"

  lb_ingress_rules = [
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

  lb_egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  # tags variable
  lb_sg_tags       = "${local.default_name}-elb-SG"
  instance_sg_tags = "${local.default_name}-instance-SG"
}
