module "azurerm_resource_group" {
  source = "../../child module/azurerm_resource_group"
  rgs    = var.rgs
}
module "azurerm_virtual_network" {
  depends_on = [module.azurerm_resource_group]
  source     = "../../child module/azurerm_virtual_network"
  vnets      = var.vnets
}
module "azurerm_subnet" {
  depends_on = [module.azurerm_virtual_network]
  source     = "../../child module/azurerm_subnet"
  subnets    = var.subnets
}
module "azurerm_virtual_machine" {
  depends_on = [module.azurerm_subnet]
  source     = "../../child module/azurerm_virtual_machine"
  vms        = var.vms
}

module "azurerm_storage_account" {
  depends_on       = [module.azurerm_resource_group]
  source           = "../../child module/azurerm_storage_account"
  storage_accounts = var.storage_accounts
}

module "azurerm_network_security_group" {
  depends_on = [module.azurerm_subnet]
  source     = "../../child module/azurerm_network_security_group"
  nsgs       = var.nsgs
}

module "azurerm_private_dns_zone" {
  depends_on        = [module.azurerm_virtual_network]
  source            = "../../child module/azurerm_private_dns_zone"
  private_dns_zones = var.private_dns_zones
}

module "azurerm_private_endpoint" {
  depends_on = [
    module.azurerm_subnet,
    module.azurerm_storage_account,
    module.azurerm_private_dns_zone,
  ]
  source            = "../../child module/azurerm_private_endpoint"
  private_endpoints = var.private_endpoints
}