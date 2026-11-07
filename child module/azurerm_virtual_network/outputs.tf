output "ids" {
  description = "Virtual network IDs keyed by the input identifier."
  value       = { for key, vnet in azurerm_virtual_network.this : key => vnet.id }
}

output "names" {
  description = "Virtual network names keyed by the input identifier."
  value       = { for key, vnet in azurerm_virtual_network.this : key => vnet.name }
}
