
output "load_balancer_arn" {
  description = "The ARN of the load balancer"
  value       = aws_lb.server_lb.arn
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.server_tg.arn
}

output "listener_arn" {
  description = "The ARN of the load balancer listener"
  value       = aws_lb_listener.server_listener.arn
}
