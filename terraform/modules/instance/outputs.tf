output "instance_id" {
  description = "The instance id."
  value       = aws_instance.test.id
}

output "instance_public_ip" {
  description = "The public IP."
  value       = aws_eip.test_eip.public_ip
}

