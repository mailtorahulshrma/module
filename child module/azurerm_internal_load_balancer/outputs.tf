output "ids" {
  description = "Internal load balancer IDs keyed by the input identifier."
  value       = { for key, lb in azurerm_lb.this : key => lb.id }
}

output "frontend_private_ip_addresses" {
  description = "Frontend private IP addresses keyed by the input identifier."
  value       = { for key, lb in azurerm_lb.this : key => lb.frontend_ip_configuration[0].private_ip_address }
}

output "backend_address_pool_ids" {
  description = "Backend pool IDs keyed by the input identifier."
  value       = { for key, pool in azurerm_lb_backend_address_pool.this : key => pool.id }
}
