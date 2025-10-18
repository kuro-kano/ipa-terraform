
# Common Defined Prefixes and Variables
locals {
  # Common prefixes for resource names and tags
  tags_prefix = "itkmitl"
  name_prefix = "prompt"

  default_name = "${local.name_prefix}91"

  # AMI for EC2 instances
  ami = "ami-052064a798f08f0d3"
}

# Tags Defined
locals {
  # VPC tags variables
  vpc_tags = "${local.default_name}-VPC"
  igw_tags = "${local.default_name}-testIGW"

  # Security Group tags variables
  lb_sg_tags       = "${local.default_name}-lb-SG"
  instance_sg_tags = "${local.default_name}-instance-SG"

  # Instance tags variable
  instance_tags = "${local.default_name}-servers"

  # Load Balancer tags variable
  lb_tags           = "${local.default_name}-web-loadbalancer"
  target_group_tags = "${local.default_name}-tgp"
  listener_tags     = "${local.default_name}-listener"
}

# Networking Variables Defined
locals {
  # VPC variable
  network_address_space = "10.0.0.0/16"
  enable_dns_hostnames  = true

  # subnet variable
  public_subnet_count  = 2
  private_subnet_count = 2

  ## [public subnet, public subnet, private subnet]
  subnet_address_space = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  ## [public subnets, private subnet]
  map_public_ip_on_launch = [true, false]

  # route table variable
  rt_cidr_block = "0.0.0.0/0"

  public_subnet_tags = [
    "${local.default_name}-publicsubnet1",
    "${local.default_name}-publicsubnet2"
  ]
  private_subnet_tags = [
    "${local.default_name}-privatesubnet1",
    "${local.default_name}-privatesubnet2"
  ]

  public_route_table_tags  = "${local.default_name}-publicRouteTable"
  private_route_table_tags = "${local.default_name}-privateRouteTable"
}

# Security Group Variables Defined
locals {
  # Instance Security Group variables
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

  # LB Security Group variables
  lb_sg_name        = "${local.default_name}-lb-SG"
  lb_sg_description = "Allow HTTP and HTTPS access"

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
}

# Instance Variables Defined
locals {

  instance_count = 2

  instance_type     = "t2.micro"
  instance_key_name = "vockey"
}

# Load Balancer Variables Defined
locals {

  lb_name     = "server-loadbalancer"
  lb_internal = false
  lb_type     = "application"

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

  # listener variable
  listener_port     = 80
  listener_protocol = "HTTP"
  ## default_action
  default_action_type = "forward"
}

# Database Variables Defined
locals {
  # Database subnet group variable
  subnet_group_name = "${local.default_name}-db-subnet-group"

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
  availability_zone   = "us-east-1c"
}
