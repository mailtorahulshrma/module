data "azurerm_subnet" "subnets" {
  for_each             = var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

# 1. Public IP

resource "azurerm_public_ip" "pips" {
  for_each            = var.vms
  name                = each.value.pip_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  allocation_method = each.value.allocation_method
  sku               = each.value.sku
}

# 2. Network Interface

resource "azurerm_network_interface" "nics" {
  for_each            = var.vms
  name                = each.value.nics_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.internal_ip
    subnet_id                     = data.azurerm_subnet.subnets[each.key].id
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = azurerm_public_ip.pips[each.key].id
  }
}

# 3. Linux Virtual Machine

resource "azurerm_linux_virtual_machine" "dev" {
  for_each            = var.vms
  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  size           = each.value.size
  admin_username = each.value.admin_username
  admin_password = each.value.admin_password

  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nics[each.key].id
  ]


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
