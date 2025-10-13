
resource "aws_lb_listener" "server_listener" {
  load_balancer_arn = aws_lb.server_lb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.server_tg.arn
  }

  tags = {
    Name = "${var.listener_tags}"
  }
}
