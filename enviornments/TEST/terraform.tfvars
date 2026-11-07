vms = {
  vm1 = {
    subnet_name          = "test-subnet"
    virtual_network_name = "test-vnet"
    resource_group_name  = "test-rg"
    pip_name             = "test-public-ip"
    allocation_method    = "Static"
    sku                  = "Standard"
    nics_name            = "test-nic"
    internal_ip          = "internal"
    vm_name              = "test-machine"
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
    name                = "test-vnet"
    location            = "eastus"
    resource_group_name = "test-rg"
    address_space       = ["10.1.0.0/16"]
  }
}

subnets = {
  subnet1 = {
    name                 = "test-subnet"
    resource_group_name  = "test-rg"
    virtual_network_name = "test-vnet"
    address_prefixes     = ["10.1.0.0/24"]
  }
}

rgs = {
  rg1 = {
    name     = "test-rg"
    location = "eastus"
  }
}

storage_accounts = {
  storage1 = {
    name                            = "teststgacct110726"
    resource_group_name             = "test-rg"
    location                        = "eastus"
    account_tier                    = "Standard"
    account_replication_type        = "LRS"
    public_network_access           = "Disabled"
    allow_nested_items_to_be_public = false
  }
}

nsgs = {
  nsg1 = {
    name                = "test-nsg"
    location            = "eastus"
    resource_group_name = "test-rg"
    subnet_ids = [
      "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/test-subnet"
    ]
  }
}

private_dns_zones = {
  blob = {
    name                = "privatelink.blob.core.windows.net"
    resource_group_name = "test-rg"
    virtual_network_links = {
      test = {
        name               = "test-blob-dns-link"
        virtual_network_id = "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet"
      }
    }
  }
}

private_endpoints = {
  storage_blob = {
    name                           = "test-storage-blob-pe"
    location                       = "eastus"
    resource_group_name            = "test-rg"
    subnet_id                      = "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/test-subnet"
    private_connection_resource_id = "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Storage/storageAccounts/teststgacct110726"
    subresource_names              = ["blob"]
    private_dns_zone_ids = [
      "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
    ]
  }
}
