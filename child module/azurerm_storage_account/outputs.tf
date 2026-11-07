output "ids" {
  description = "Storage account IDs keyed by the input identifier."
  value       = { for key, account in azurerm_storage_account.this : key => account.id }
}

output "names" {
  description = "Storage account names keyed by the input identifier."
  value       = { for key, account in azurerm_storage_account.this : key => account.name }
}
