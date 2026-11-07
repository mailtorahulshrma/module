output "ids" {
  description = "Private endpoint IDs keyed by the input identifier."
  value       = { for key, endpoint in azurerm_private_endpoint.this : key => endpoint.id }
}

output "names" {
  description = "Private endpoint names keyed by the input identifier."
  value       = { for key, endpoint in azurerm_private_endpoint.this : key => endpoint.name }
}
