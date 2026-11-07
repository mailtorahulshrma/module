output "ids" {
  description = "Application Gateway IDs keyed by the input identifier."
  value       = { for key, gateway in azurerm_application_gateway.this : key => gateway.id }
}

output "private_ip_addresses" {
  description = "Application Gateway private frontend IPs keyed by the input identifier."
  value       = { for key, gateway in azurerm_application_gateway.this : key => gateway.frontend_ip_configuration[0].private_ip_address }
}
