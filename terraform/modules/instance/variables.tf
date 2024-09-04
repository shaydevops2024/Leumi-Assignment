variable "region" {
  description = "The AWS region."
  type        = string
  default     = "us-east-1"
}

variable "ami" {
  description = "The AMI id."
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Ubuntu AMI ID
}

variable "instance_type" {
  description = "The type of instance."
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The key pair name."
  type        = string
  default     = "test"
}

variable "instance_name" {
  description = "The instance name."
  type        = string
  default     = "test"
}

variable "leumi_proxy_ip" {
  description = "The IP of the Leumi proxy."
  type        = string
  default     = "91.231.246.50/32"
}

variable "vpc_id" {
  description = "The VPC id."
  type        = string
}

variable "subnet_id" {
  description = "The sunet id."
  type        = string
}

