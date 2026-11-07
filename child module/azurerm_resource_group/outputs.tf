output "ids" {
  description = "Resource group IDs keyed by the input identifier."
  value       = { for key, resource_group in azurerm_resource_group.this : key => resource_group.id }
}

output "names" {
  description = "Resource group names keyed by the input identifier."
  value       = { for key, resource_group in azurerm_resource_group.this : key => resource_group.name }
}
