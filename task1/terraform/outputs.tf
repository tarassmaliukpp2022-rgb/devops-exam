output "droplet_ip" {
  description = "Публічна IP-адреса ВМ"
  value       = digitalocean_droplet.main.ipv4_address
}

output "vpc_id" {
  description = "ID VPC"
  value       = digitalocean_vpc.main.id
}

output "bucket_name" {
  description = "Назва bucket"
  value       = digitalocean_spaces_bucket.main.name
}

output "bucket_endpoint" {
  description = "Endpoint bucket"
  value       = digitalocean_spaces_bucket.main.bucket_domain_name
}

output "firewall_id" {
  description = "ID Firewall"
  value       = digitalocean_firewall.main.id
}
