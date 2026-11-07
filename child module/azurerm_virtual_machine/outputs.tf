output "ids" {
  description = "Virtual machine IDs keyed by the input identifier."
  value       = { for key, vm in azurerm_linux_virtual_machine.this : key => vm.id }
}

output "names" {
  description = "Virtual machine names keyed by the input identifier."
  value       = { for key, vm in azurerm_linux_virtual_machine.this : key => vm.name }
}

output "network_interface_ids" {
  description = "Network interface IDs keyed by the input identifier."
  value       = { for key, nic in azurerm_network_interface.this : key => nic.id }
}

output "public_ip_addresses" {
  description = "Assigned public IP addresses keyed by the input identifier."
  value       = { for key, ip in azurerm_public_ip.this : key => ip.ip_address }
}
