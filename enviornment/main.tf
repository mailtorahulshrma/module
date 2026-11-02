# module "azurerm_resource_group" {
#   source = "git::https://github.com/mailtorahulshrma/module.git//azurerm_resource_group?ref=main"
#   rgs    = var.rgs

# }
# module "azurerm_virtual_network" {
#   depends_on = [module.azurerm_resource_group]
#   source     = "git::https://github.com/mailtorahulshrma/module.git//azurerm_virtual_network?ref=main"
#   vnets      = var.vnets
# }
# module "azurerm_subnet" {
#   depends_on = [module.azurerm_virtual_network]
#   source     = "git::https://github.com/mailtorahulshrma/module.git//azurerm_subnet?ref=main"
#   subnets    = var.subnets
# }
# module "azurerm_virtual_machine" {
#   depends_on = [module.azurerm_subnet]
#   source     = "git::https://github.com/mailtorahulshrma/module.git//azurerm_virtual_machine?ref=main"
#   vms        = var.vms
# }