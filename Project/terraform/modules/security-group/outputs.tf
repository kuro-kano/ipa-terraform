
output "instance_sg_id" {
  description = "The ID of the instance security group"
  value       = aws_security_group.instance_sg.id
}

output "elb_sg_id" {
  description = "The ID of the ELB security group"
  value       = aws_security_group.elb_sg.id
}
