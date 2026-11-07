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

module "azurerm_internal_load_balancer" {
  depends_on     = [module.azurerm_virtual_machine]
  source         = "../../child module/azurerm_internal_load_balancer"
  load_balancers = var.internal_load_balancers
}

module "azurerm_application_gateway" {
  depends_on           = [module.azurerm_internal_load_balancer]
  source               = "../../child module/azurerm_application_gateway"
  application_gateways = var.application_gateways
}

module "azurerm_bastion" {
  depends_on = [module.azurerm_subnet]
  source     = "../../child module/azurerm_bastion"
  bastions   = var.bastions
}

module "azurerm_nat_gateway" {
  depends_on   = [module.azurerm_subnet]
  source       = "../../child module/azurerm_nat_gateway"
  nat_gateways = var.nat_gateways
}
