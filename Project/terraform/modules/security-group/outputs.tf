
output "instance_sg_id" {
  description = "The ID of the instance security group"
  value       = aws_security_group.instance_sg.id
}

output "lb_sg_id" {
  description = "The ID of the LB security group"
  value       = aws_security_group.lb_sg.id
}
