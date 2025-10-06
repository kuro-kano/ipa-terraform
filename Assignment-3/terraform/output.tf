# Load Balancer DNS
output "load_balancer_dns" {
  description = "DNS name of the load balancer"
  value       = aws_elb.elb-webLB.dns_name # แก้จาก aws_lb.main
}

# S3 Bucket Information
output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.content.id
}

output "s3_website_url" {
  description = "URL to access the HTML file in S3"
  value       = "https://${aws_s3_bucket.content.bucket_domain_name}/index.html"
}

output "s3_bucket_url" {
  description = "Direct S3 bucket URL"
  value       = "https://${aws_s3_bucket.content.id}.s3.${var.region}.amazonaws.com/index.html"
}

# EC2 Instance Information
output "ec2_instance_ids" {
  description = "IDs of the EC2 instances"
  value       = aws_instance.Server[*].id # แก้จาก aws_instance.web
}

output "ec2_public_ips" {
  description = "Public IP addresses of the EC2 instances"
  value       = aws_instance.Server[*].public_ip # แก้จาก aws_instance.web
}

# VPC Information
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main_VPC.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

# Application URLs
output "application_url" {
  description = "URL to access the application via Load Balancer"
  value       = "http://${aws_elb.elb-webLB.dns_name}" # แก้จาก aws_lb.main
}