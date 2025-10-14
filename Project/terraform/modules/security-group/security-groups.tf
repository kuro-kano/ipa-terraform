
resource "aws_security_group" "instance_sg" {
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

resource "aws_security_group" "lb_sg" {
  name        = var.lb_name
  description = var.lb_description

  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.lb_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.lb_egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = var.lb_sg_tags
  }
}
