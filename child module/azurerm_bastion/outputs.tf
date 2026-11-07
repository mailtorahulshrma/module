output "ids" {
  description = "Bastion host IDs keyed by the input identifier."
  value       = { for key, host in azurerm_bastion_host.this : key => host.id }
}

output "public_ip_addresses" {
  description = "Bastion public IP addresses keyed by the input identifier."
  value       = { for key, ip in azurerm_public_ip.this : key => ip.ip_address }
}
