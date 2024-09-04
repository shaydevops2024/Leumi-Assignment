output "vpc_id" {
  description = "The VPC id."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "The public subnets ids."
  value       = aws_subnet.public[*].id
}

