output "instance_id" {
  description = "The instance id."
  value       = module.ec2_instance.instance_id
}

output "instance_public_ip" {
  description = "The public IP."
  value       = module.ec2_instance.instance_public_ip
}

output "nlb_dns_name" {
  description = "The DNS name."
  value       = module.nlb.nlb_dns_name
}

