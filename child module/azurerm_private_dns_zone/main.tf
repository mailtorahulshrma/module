resource "azurerm_private_dns_zone" "this" {
  for_each = var.private_dns_zones

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = local.virtual_network_links

  name                 = each.value.name
  private_dns_zone_id  = each.value.private_dns_zone_id
  virtual_network_id   = each.value.virtual_network_id
  registration_enabled = each.value.registration_enabled
  tags                 = each.value.tags
}

locals {
  virtual_network_links = merge(
    {},
    [
      for zone_key, zone in var.private_dns_zones : {
        for link_key, link in zone.virtual_network_links : "${zone_key}/${link_key}" => {
          name                 = link.name
          private_dns_zone_id  = azurerm_private_dns_zone.this[zone_key].id
          virtual_network_id   = link.virtual_network_id
          registration_enabled = link.registration_enabled
          tags                 = link.tags
        }
      }
    ]...
  )
}