output "ids" {
  description = "Subnet IDs keyed by the input identifier."
  value       = { for key, subnet in azurerm_subnet.this : key => subnet.id }
}

output "names" {
  description = "Subnet names keyed by the input identifier."
  value       = { for key, subnet in azurerm_subnet.this : key => subnet.name }
}
