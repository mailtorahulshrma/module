resource "azurerm_public_ip" "this" {
  for_each = {
    for key, vm in var.vms : key => vm
    if vm.pip_name != null
  }

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
    subnet_id                     = each.value.subnet_id
    private_ip_address_allocation = lower(each.value.internal_ip) == "static" ? "Static" : "Dynamic"
    private_ip_address            = each.value.private_ip_address
    public_ip_address_id          = each.value.pip_name == null ? null : azurerm_public_ip.this[each.key].id
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
  custom_data                     = each.value.custom_data == null ? null : base64encode(each.value.custom_data)
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
