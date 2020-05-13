output "instance_private_ip" {
  description = "EC2 private ip address"
  value       = module.elasticsearch_kibana.aws_instance_private_ip
}

output "private_domain_name" {
  description = "Private domain name"
  value       = module.elasticsearch_kibana.dns_record_private
}