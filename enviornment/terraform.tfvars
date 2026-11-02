vms = {
  vm1 = {
    subnet_name          = "dev-subnet"
    virtual_network_name = "dev-vnet"
    resource_group_name  = "dev-rg"
    pip_name             = "dev-public-ip"
    allocation_method    = "Static"
    sku                  = "Standard"
    nics_name            = "dev-nic"
    internal_ip          = "internal"
    vm_name              = "dev-machine"
    size                 = "Standard_D2alds_v7"
    admin_username       = "adminuser"
    admin_password       = "Password@1234"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    publisher            = "Canonical"
    offer                = "ubuntu-22_04-lts"
    image_sku            = "server"
    version              = "latest"
    location             = "eastus"


  }
}
vnets = {
  vnet1 = {
    name                = "dev-vnet"
    location            = "eastus"
    resource_group_name = "dev-rg"
    address_space       = ["10.0.0.0/16"]
  }

}
subnets = {
  subnet1 = {
    name                 = "dev-subnet"
    resource_group_name  = "dev-rg"
    virtual_network_name = "dev-vnet"
    address_prefixes     = ["10.0.0.0/24"]
  }
}
rgs = {
  rg1 = {
    name     = "dev-rg"
    location = "eastus"
  }
}