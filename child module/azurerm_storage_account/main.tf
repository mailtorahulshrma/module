resource "azurerm_storage_account" "this" {
  for_each = var.storage_accounts

  name                       = each.value.name
  resource_group_name        = each.value.resource_group_name
  location                   = each.value.location
  account_tier               = each.value.account_tier
  account_replication_type   = each.value.account_replication_type
  account_kind               = each.value.account_kind
  min_tls_version            = each.value.min_tls_version
  https_traffic_only_enabled = each.value.https_traffic_only_enabled
  public_network_access = each.value.public_network_access != null ? each.value.public_network_access : (
    each.value.public_network_access_enabled == false ? "Disabled" : "Enabled"
  )
  allow_nested_items_to_be_public = each.value.allow_nested_items_to_be_public
  tags                            = each.value.tags
}
