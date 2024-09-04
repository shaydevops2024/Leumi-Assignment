variable "vpc_cidr_block" {
  description = "The CIDR block."
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The VPC name."
  type        = string
  default     = "main-vpc"
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "The availability zones."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

