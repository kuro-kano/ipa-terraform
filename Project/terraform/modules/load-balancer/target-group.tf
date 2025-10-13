
resource "aws_lb_target_group" "server_tg" {
  name     = var.tg_name
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id

  health_check {
    enabled             = var.hc_enabled
    healthy_threshold   = var.hc_healthy
    unhealthy_threshold = var.hc_unhealthy
    timeout             = var.hc_timeout
    protocol            = var.hc_protocol
    path                = var.hc_path
    interval            = var.hc_interval
    matcher             = var.hc_matcher
  }

  tags = {
    Name = "${var.target_group_tags}"
  }
}

resource "aws_lb_target_group_attachment" "server_attachment" {
  count            = length(var.instance_ids)
  target_group_arn = aws_lb_target_group.server_tg.arn
  target_id        = var.instance_ids[count.index]
  port             = var.tg_port
}
