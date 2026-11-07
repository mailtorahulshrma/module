resource "azurerm_public_ip" "this" {
  for_each = var.bastions

  name                = each.value.public_ip_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = each.value.tags
}

resource "azurerm_bastion_host" "this" {
  for_each = var.bastions

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku
  scale_units         = each.value.scale_units
  tags                = each.value.tags

  ip_configuration {
    name                 = "${each.value.name}-ipconfig"
    subnet_id            = each.value.subnet_id
    public_ip_address_id = azurerm_public_ip.this[each.key].id
  }
}
