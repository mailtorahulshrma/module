resource "azurerm_network_security_group" "this" {
  for_each = var.nsgs

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags

  dynamic "security_rule" {
    for_each = each.value.security_rules
    content {
      name                         = security_rule.value.name
      priority                     = security_rule.value.priority
      direction                    = security_rule.value.direction
      access                       = security_rule.value.access
      protocol                     = security_rule.value.protocol
      source_port_range            = security_rule.value.source_port_range
      source_port_ranges           = security_rule.value.source_port_ranges
      destination_port_range       = security_rule.value.destination_port_range
      destination_port_ranges      = security_rule.value.destination_port_ranges
      source_address_prefix        = security_rule.value.source_address_prefix
      source_address_prefixes      = security_rule.value.source_address_prefixes
      destination_address_prefix   = security_rule.value.destination_address_prefix
      destination_address_prefixes = security_rule.value.destination_address_prefixes
      description                  = security_rule.value.description
    }
  }
}

locals {
  subnet_associations = {
    for association in flatten([
      for nsg_key, nsg in var.nsgs : [
        for subnet_id in nsg.subnet_ids : {
          key       = "${nsg_key}/${subnet_id}"
          nsg_key   = nsg_key
          subnet_id = subnet_id
        }
      ]
    ]) : association.key => association
  }
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = local.subnet_associations

  subnet_id                 = each.value.subnet_id
  network_security_group_id = azurerm_network_security_group.this[each.value.nsg_key].id
}