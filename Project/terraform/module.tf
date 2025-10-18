
module "networking" {
  source = "./modules/networking"

  # vpc variable
  network_address_space = local.network_address_space
  enable_dns_hostnames  = local.enable_dns_hostnames

  # subnet variable
  public_subnet_count  = local.public_subnet_count
  private_subnet_count = local.private_subnet_count

  ## [public subnet, public subnet, private subnet]
  subnet_address_space = local.subnet_address_space
  availability_zones   = local.availability_zones
  ## [public subnets, private subnet]
  map_public_ip_on_launch = local.map_public_ip_on_launch

  # route table variable
  rt_cidr_block = local.rt_cidr_block

  # tags variable
  vpc_tags = local.vpc_tags
  igw_tags = local.igw_tags

  public_subnet_tags  = local.public_subnet_tags
  private_subnet_tags = local.private_subnet_tags

  public_route_table_tags  = local.public_route_table_tags
  private_route_table_tags = local.private_route_table_tags
}

module "security-group" {
  source = "./modules/security-group"

  # vpc_id variable from networking module
  vpc_id = module.networking.vpc_id

  # instance security group variable
  instance_sg_name        = local.instance_sg_name
  instance_sg_description = local.instance_sg_description

  instance_ingress_rules = local.instance_ingress_rules

  instance_egress_rules = local.instance_egress_rules

  # LB security group variable
  lb_name        = local.lb_sg_name
  lb_description = local.lb_sg_description

  lb_ingress_rules = local.lb_ingress_rules
  lb_egress_rules  = local.lb_egress_rules

  # tags variable
  lb_sg_tags       = local.lb_sg_tags
  instance_sg_tags = local.instance_sg_tags
}

module "instance" {
  source = "./modules/instance"

  # instance variable
  instance_count = local.instance_count

  ami                    = var.ami
  type                   = local.instance_type
  key_name               = local.instance_key_name
  vpc_security_group_ids = [module.security-group.instance_sg_id]
  subnet_ids             = module.networking.public_subnet_ids

  # tags variable
  instance_tags = local.instance_tags
}

module "load-balancer" {
  source = "./modules/load-balancer"

  # variable
  vpc_id       = module.networking.vpc_id
  instance_ids = module.instance.instance_ids

  # load balancer variable
  lb_name            = local.lb_name
  lb_internal        = local.lb_internal
  lb_type            = local.lb_type
  lb_security_groups = [module.security-group.lb_sg_id]
  lb_subnets         = module.networking.public_subnet_ids

  lb_deletion_protection = local.lb_deletion_protection

  # target group variable
  tg_name     = local.tg_name
  tg_port     = local.tg_port
  tg_protocol = local.tg_protocol

  ## health check variable
  hc_enabled   = local.hc_enabled
  hc_healthy   = local.hc_healthy
  hc_unhealthy = local.hc_unhealthy
  hc_timeout   = local.hc_timeout
  hc_protocol  = local.hc_protocol
  hc_path      = local.hc_path
  hc_interval  = local.hc_interval
  hc_matcher   = local.hc_matcher

  # listener variable
  listener_port     = local.listener_port
  listener_protocol = local.listener_protocol
  ## default_action
  default_action_type = local.default_action_type

  # tags variable
  lb_tags           = local.lb_tags
  target_group_tags = local.target_group_tags
  listener_tags     = local.listener_tags
}

module "database" {
  source = "./modules/database"

  # Database subnet group variable
  private_subnet_ids = module.networking.private_subnet_ids
  subnet_group_name  = local.subnet_group_name

  # Database variable
  allocated_storage = local.allocated_storage
  db_name           = local.db_name
  engine            = local.engine
  engine_version    = local.engine_version
  instance_class    = local.instance_class
  identifier        = local.identifier

  username = local.username
  password = local.password

  group_name          = local.group_name
  skip_final_snapshot = local.skip_final_snapshot
  availability_zone   = local.availability_zone
}
