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

storage_accounts = {
  storage1 = {
    name                            = "devstgacct110726"
    resource_group_name             = "dev-rg"
    location                        = "eastus"
    account_tier                    = "Standard"
    account_replication_type        = "LRS"
    public_network_access           = "Disabled"
    allow_nested_items_to_be_public = false
  }
}

nsgs = {
  nsg1 = {
    name                = "dev-nsg"
    location            = "eastus"
    resource_group_name = "dev-rg"
    subnet_ids = [
      "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/dev-rg/providers/Microsoft.Network/virtualNetworks/dev-vnet/subnets/dev-subnet"
    ]
  }
}

private_dns_zones = {
  blob = {
    name                = "privatelink.blob.core.windows.net"
    resource_group_name = "dev-rg"
    virtual_network_links = {
      dev = {
        name               = "dev-blob-dns-link"
        virtual_network_id = "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/dev-rg/providers/Microsoft.Network/virtualNetworks/dev-vnet"
      }
    }
  }
}

private_endpoints = {
  storage_blob = {
    name                           = "dev-storage-blob-pe"
    location                       = "eastus"
    resource_group_name            = "dev-rg"
    subnet_id                      = "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/dev-rg/providers/Microsoft.Network/virtualNetworks/dev-vnet/subnets/dev-subnet"
    private_connection_resource_id = "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/dev-rg/providers/Microsoft.Storage/storageAccounts/devstgacct110726"
    subresource_names              = ["blob"]
    private_dns_zone_ids = [
      "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/dev-rg/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
    ]
  }
}