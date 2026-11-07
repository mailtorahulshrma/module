resource "azurerm_public_ip" "this" {
  for_each = var.nat_gateways

  name                = each.value.public_ip_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = each.value.tags
}

resource "azurerm_nat_gateway" "this" {
  for_each = var.nat_gateways

  name                    = each.value.name
  location                = each.value.location
  resource_group_name     = each.value.resource_group_name
  sku_name                = each.value.sku_name
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes
  tags                    = each.value.tags

}

resource "azurerm_nat_gateway_public_ip_association" "this" {
  for_each = var.nat_gateways

  nat_gateway_id       = azurerm_nat_gateway.this[each.key].id
  public_ip_address_id = azurerm_public_ip.this[each.key].id
}

locals {
  subnet_associations = {
    for association in flatten([
      for nat_key, nat in var.nat_gateways : [
        for subnet_index, subnet_id in nat.subnet_ids : {
          key       = "${nat_key}/${subnet_index}"
          nat_key   = nat_key
          subnet_id = subnet_id
        }
      ]
    ]) : association.key => association
  }
}

resource "azurerm_subnet_nat_gateway_association" "this" {
  for_each = local.subnet_associations

  subnet_id      = each.value.subnet_id
  nat_gateway_id = azurerm_nat_gateway.this[each.value.nat_key].id
}
