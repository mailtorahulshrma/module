rgs = {
  rg1 = {
    name     = "test-rg"
    location = "eastus"
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

# Two workload subnets plus the dedicated Azure-required Bastion and App Gateway subnets.
subnets = {
  workload_a = {
    name                 = "test-subnet-a"
    resource_group_name  = "test-rg"
    virtual_network_name = "test-vnet"
    address_prefixes     = ["10.1.1.0/24"]
  }
  workload_b = {
    name                 = "test-subnet-b"
    resource_group_name  = "test-rg"
    virtual_network_name = "test-vnet"
    address_prefixes     = ["10.1.2.0/24"]
  }
  bastion = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "test-rg"
    virtual_network_name = "test-vnet"
    address_prefixes     = ["10.1.3.0/26"]
  }
  app_gateway = {
    name                 = "test-appgw-subnet"
    resource_group_name  = "test-rg"
    virtual_network_name = "test-vnet"
    address_prefixes     = ["10.1.4.0/24"]
  }
}

vms = {
  app_a_1 = {
    subnet_id            = "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/test-subnet-a"
    resource_group_name  = "test-rg"
    nics_name            = "test-app-a-1-nic"
    internal_ip          = "Static"
    private_ip_address   = "10.1.1.4"
    vm_name              = "test-app-a-1"
    size                 = "Standard_D2alds_v7"
    admin_username       = "azureadmin"
    admin_password       = "ChangeThis!Test12345"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    publisher            = "Canonical"
    offer                = "ubuntu-22_04-lts"
    image_sku            = "server"
    version              = "latest"
    location             = "eastus"
    custom_data          = <<-EOT
      #!/bin/bash
      apt-get update -y
      apt-get install -y nginx
      systemctl enable --now nginx
      echo "TEST backend app-a-1" > /var/www/html/index.html
    EOT
  }
  app_a_2 = {
    subnet_id            = "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/test-subnet-a"
    resource_group_name  = "test-rg"
    nics_name            = "test-app-a-2-nic"
    internal_ip          = "Static"
    private_ip_address   = "10.1.1.5"
    vm_name              = "test-app-a-2"
    size                 = "Standard_D2alds_v7"
    admin_username       = "azureadmin"
    admin_password       = "ChangeThis!Test12345"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    publisher            = "Canonical"
    offer                = "ubuntu-22_04-lts"
    image_sku            = "server"
    version              = "latest"
    location             = "eastus"
    custom_data          = <<-EOT
      #!/bin/bash
      apt-get update -y
      apt-get install -y nginx
      systemctl enable --now nginx
      echo "TEST backend app-a-2" > /var/www/html/index.html
    EOT
  }
  app_b_1 = {
    subnet_id            = "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/test-subnet-b"
    resource_group_name  = "test-rg"
    nics_name            = "test-app-b-1-nic"
    internal_ip          = "Static"
    private_ip_address   = "10.1.2.4"
    vm_name              = "test-app-b-1"
    size                 = "Standard_D2alds_v7"
    admin_username       = "azureadmin"
    admin_password       = "ChangeThis!Test12345"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    publisher            = "Canonical"
    offer                = "ubuntu-22_04-lts"
    image_sku            = "server"
    version              = "latest"
    location             = "eastus"
    custom_data          = <<-EOT
      #!/bin/bash
      apt-get update -y
      apt-get install -y nginx
      systemctl enable --now nginx
      echo "TEST backend app-b-1" > /var/www/html/index.html
    EOT
  }
  app_b_2 = {
    subnet_id            = "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/test-subnet-b"
    resource_group_name  = "test-rg"
    nics_name            = "test-app-b-2-nic"
    internal_ip          = "Static"
    private_ip_address   = "10.1.2.5"
    vm_name              = "test-app-b-2"
    size                 = "Standard_D2alds_v7"
    admin_username       = "azureadmin"
    admin_password       = "ChangeThis!Test12345"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    publisher            = "Canonical"
    offer                = "ubuntu-22_04-lts"
    image_sku            = "server"
    version              = "latest"
    location             = "eastus"
    custom_data          = <<-EOT
      #!/bin/bash
      apt-get update -y
      apt-get install -y nginx
      systemctl enable --now nginx
      echo "TEST backend app-b-2" > /var/www/html/index.html
    EOT
  }
}

internal_load_balancers = {
  app = {
    name                        = "test-internal-lb"
    location                    = "eastus"
    resource_group_name         = "test-rg"
    subnet_id                   = "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/test-subnet-a"
    frontend_private_ip_address = "10.1.1.10"
    backend_pool_name           = "test-app-backend-pool"
    backend_nics = {
      app_a_1 = {
        network_interface_id  = "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Network/networkInterfaces/test-app-a-1-nic"
        ip_configuration_name = "test-app-a-1-nic-ipconfig"
      }
      app_a_2 = {
        network_interface_id  = "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Network/networkInterfaces/test-app-a-2-nic"
        ip_configuration_name = "test-app-a-2-nic-ipconfig"
      }
      app_b_1 = {
        network_interface_id  = "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Network/networkInterfaces/test-app-b-1-nic"
        ip_configuration_name = "test-app-b-1-nic-ipconfig"
      }
      app_b_2 = {
        network_interface_id  = "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Network/networkInterfaces/test-app-b-2-nic"
        ip_configuration_name = "test-app-b-2-nic-ipconfig"
      }
    }
    probes = {
      http = {
        name     = "test-app-http-probe"
        protocol = "Tcp"
        port     = 80
      }
    }
    rules = {
      http = {
        name                = "test-app-http-rule"
        protocol            = "Tcp"
        frontend_port       = 80
        backend_port        = 80
        probe_name          = "http"
        floating_ip_enabled = false
      }
    }
  }
}

application_gateways = {
  app = {
    name                = "test-public-appgw"
    location            = "eastus"
    resource_group_name = "test-rg"
    subnet_id           = "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/test-appgw-subnet"
    public_ip_name      = "test-appgw-pip"
    backend_addresses   = ["10.1.1.10"]
    frontend_port       = 80
    backend_port        = 80
    backend_protocol    = "Http"
    listener_protocol   = "Http"
    probe = {
      name     = "test-appgw-http-probe"
      protocol = "Http"
      path     = "/"
      host     = "10.1.1.10"
    }
  }
}

bastions = {
  main = {
    name                = "test-bastion"
    location            = "eastus"
    resource_group_name = "test-rg"
    subnet_id           = "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/AzureBastionSubnet"
    public_ip_name      = "test-bastion-pip"
    sku                 = "Standard"
    scale_units         = 2
  }
}

nat_gateways = {
  main = {
    name                = "test-nat-gateway"
    location            = "eastus"
    resource_group_name = "test-rg"
    public_ip_name      = "test-nat-pip"
    subnet_ids = [
      "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/test-subnet-a",
      "/subscriptions/b6821f5d-653e-4faa-8154-8314d9ce127e/resourceGroups/test-rg/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/test-subnet-b"
    ]
  }
}
