
# Main Variables
variable "vpc_id" {
  description = "VPC ID for the Target Group"
  type        = string
}

variable "instance_ids" {
  description = "List of EC2 Instance IDs to attach to the Target Group"
  type        = list(string)
}

# Load Balancer variables
variable "lb_name" {
  description = "Name of the Load Balancer"
  type        = string
}

variable "lb_type" {
  description = "Type of the Load Balancer"
  type        = string
}

variable "lb_internal" {
  description = "Whether the Load Balancer is internal"
  type        = bool
}

variable "lb_security_groups" {
  description = "Security Groups for the Load Balancer"
  type        = list(string)
}

variable "lb_subnets" {
  description = "Subnets for the Load Balancer"
  type        = list(string)
}

variable "lb_deletion_protection" {
  description = "Whether deletion protection is enabled for the Load Balancer"
  type        = bool
  default     = false
}

# Target Group variables
variable "tg_name" {
  description = "Name of the Target Group"
  type        = string
}

variable "tg_port" {
  description = "Port for the Target Group"
  type        = number
}

variable "tg_protocol" {
  description = "Protocol for the Target Group"
  type        = string
}

# Health Check variables
variable "hc_enabled" {
  description = "Whether health checks are enabled"
  type        = bool
  default     = true
}

variable "hc_healthy" {
  description = "Number of healthy thresholds"
  type        = number
  default     = 2
}

variable "hc_unhealthy" {
  description = "Number of unhealthy thresholds"
  type        = number
  default     = 2
}

variable "hc_timeout" {
  description = "Timeout for health checks (in seconds)"
  type        = number
  default     = 5
}

variable "hc_protocol" {
  description = "Protocol for health checks"
  type        = string
  default     = "HTTP"
}

variable "hc_path" {
  description = "Path for health checks"
  type        = string
  default     = "/"
}

variable "hc_interval" {
  description = "Interval between health checks (in seconds)"
  type        = number
  default     = 30
}

variable "hc_matcher" {
  description = "HTTP codes to use when checking for a successful response from a target"
  type        = string
  default     = "200"
}

# Listener variables
variable "listener_port" {
  description = "Port for the Load Balancer Listener"
  type        = number
}

variable "listener_protocol" {
  description = "Protocol for the Load Balancer Listener"
  type        = string
}

variable "default_action_type" {
  description = "Type of default action for the Listener"
  type        = string
  default     = "forward"
}

# Tags variables
variable "lb_tags" {
  description = "Tags for the Load Balancer"
  type        = string
}

variable "target_group_tags" {
  description = "Tags for the Target Group"
  type        = string
}

variable "listener_tags" {
  description = "Tags for the Load Balancer Listener"
  type        = string
}
