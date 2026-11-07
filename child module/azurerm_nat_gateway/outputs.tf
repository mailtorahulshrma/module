output "ids" {
  description = "NAT gateway IDs keyed by the input identifier."
  value       = { for key, nat in azurerm_nat_gateway.this : key => nat.id }
}

output "public_ip_addresses" {
  description = "NAT gateway public IP addresses keyed by the input identifier."
  value       = { for key, ip in azurerm_public_ip.this : key => ip.ip_address }
}
