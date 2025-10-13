
resource "aws_security_group" "server_sg" {
  name        = var.instance_sg_name
  description = var.instance_sg_description

  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.instance_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.instance_egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = var.instance_sg_tags
  }
}

resource "aws_security_group" "elb_sg" {
  name        = var.elb_name
  description = var.elb_description

  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.elb_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.elb_egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = var.elb_sg_tags
  }
}
