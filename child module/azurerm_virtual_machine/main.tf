data "azurerm_subnet" "this" {
  for_each = var.vms

  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

resource "azurerm_public_ip" "this" {
  for_each = var.vms

  name                = each.value.pip_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}

resource "azurerm_network_interface" "this" {
  for_each = var.vms

  name                = each.value.nics_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "${each.value.nics_name}-ipconfig"
    subnet_id                     = data.azurerm_subnet.this[each.key].id
    private_ip_address_allocation = lower(each.value.internal_ip) == "static" ? "Static" : "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  for_each = var.vms

  name                            = each.value.vm_name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = sensitive(each.value.admin_password)
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.this[each.key].id]

  os_disk {
    caching              = each.value.caching
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.image_sku
    version   = each.value.version
  }
}
