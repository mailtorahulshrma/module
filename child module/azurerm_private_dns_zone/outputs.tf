output "ids" {
  description = "Private DNS zone IDs keyed by the input identifier."
  value       = { for key, zone in azurerm_private_dns_zone.this : key => zone.id }
}

output "names" {
  description = "Private DNS zone names keyed by the input identifier."
  value       = { for key, zone in azurerm_private_dns_zone.this : key => zone.name }
}