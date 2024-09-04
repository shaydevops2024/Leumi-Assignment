variable "nlb_name" {
  description = "The name of the NLB."
  type        = string
  default     = "test-nlb"
}

variable "internal" {
  description = "If true, NLB will be internal."
  type        = bool
  default     = false
}

variable "subnets" {
  description = "The subnets for the NLB."
  type        = list(string)
}

variable "tg_name" {
  description = "The target group name."
  type        = string
  default     = "test-tg"
}

variable "tg_port" {
  description = "The target group port."
  type        = number
  default     = 80
}

variable "tg_protocol" {
  description = "The target group protocol."
  type        = string
  default     = "TCP"
}

variable "vpc_id" {
  description = "The VPC id."
  type        = string
}

variable "health_check_protocol" {
  description = "The health check protocol."
  type        = string
  default     = "TCP"
}

variable "health_check_port" {
  description = "The health check port."
  type        = number
  default     = 80
}

variable "target_id" {
  description = "The target id."
  type        = string
}

variable "listener_port" {
  description = "The listener port."
  type        = number
  default     = 80
}

variable "listener_protocol" {
  description = "The listener protocol."
  type        = string
  default     = "TCP"
}

