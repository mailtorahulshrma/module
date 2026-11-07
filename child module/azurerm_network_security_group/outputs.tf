output "ids" {
  description = "Network security group IDs keyed by the input identifier."
  value       = { for key, nsg in azurerm_network_security_group.this : key => nsg.id }
}

output "names" {
  description = "Network security group names keyed by the input identifier."
  value       = { for key, nsg in azurerm_network_security_group.this : key => nsg.name }
}