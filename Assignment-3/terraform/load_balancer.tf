
resource "aws_elb" "elb-webLB" {
  name            = "elb-webLB"
  subnets         = aws_subnet.public[*].id
  security_groups = [aws_security_group.allow_ssh_web.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    target              = "HTTP:80/"
    interval            = 30
  }

  instances                   = aws_instance.Server[*].id
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "elb-webLB"
  }
}
