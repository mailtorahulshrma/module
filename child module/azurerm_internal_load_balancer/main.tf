resource "azurerm_lb" "this" {
  for_each = var.load_balancers

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku
  tags                = each.value.tags

  frontend_ip_configuration {
    name                          = "${each.value.name}-frontend"
    subnet_id                     = each.value.subnet_id
    private_ip_address            = each.value.frontend_private_ip_address
    private_ip_address_allocation = "Static"
  }
}

resource "azurerm_lb_backend_address_pool" "this" {
  for_each = var.load_balancers

  name            = each.value.backend_pool_name
  loadbalancer_id = azurerm_lb.this[each.key].id
}

locals {
  backend_nic_associations = {
    for association in flatten([
      for lb_key, lb in var.load_balancers : [
        for nic_key, nic in lb.backend_nics : {
          key                   = "${lb_key}/${nic_key}"
          lb_key                = lb_key
          network_interface_id  = nic.network_interface_id
          ip_configuration_name = nic.ip_configuration_name
        }
      ]
    ]) : association.key => association
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "this" {
  for_each = local.backend_nic_associations

  network_interface_id    = each.value.network_interface_id
  ip_configuration_name   = each.value.ip_configuration_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.this[each.value.lb_key].id
}

resource "azurerm_lb_probe" "this" {
  for_each = {
    for item in flatten([
      for lb_key, lb in var.load_balancers : [
        for probe_key, probe in lb.probes : {
          key          = "${lb_key}/${probe_key}"
          lb_key       = lb_key
          name         = probe.name
          protocol     = probe.protocol
          port         = probe.port
          request_path = probe.request_path
        }
      ]
    ]) : item.key => item
  }

  name            = each.value.name
  loadbalancer_id = azurerm_lb.this[each.value.lb_key].id
  protocol        = each.value.protocol
  port            = each.value.port
  request_path    = each.value.request_path
}

resource "azurerm_lb_rule" "this" {
  for_each = {
    for item in flatten([
      for lb_key, lb in var.load_balancers : [
        for rule_key, rule in lb.rules : {
          key                     = "${lb_key}/${rule_key}"
          lb_key                  = lb_key
          name                    = rule.name
          protocol                = rule.protocol
          frontend_port           = rule.frontend_port
          backend_port            = rule.backend_port
          probe_name              = rule.probe_name
          idle_timeout_in_minutes = rule.idle_timeout_in_minutes
          floating_ip_enabled     = rule.floating_ip_enabled
          disable_outbound_snat   = rule.disable_outbound_snat
          load_distribution       = rule.load_distribution
        }
      ]
    ]) : item.key => item
  }

  name                           = each.value.name
  loadbalancer_id                = azurerm_lb.this[each.value.lb_key].id
  frontend_ip_configuration_name = "${var.load_balancers[each.value.lb_key].name}-frontend"
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this[each.value.lb_key].id]
  probe_id = each.value.probe_name == null ? null : azurerm_lb_probe.this[
    "${each.value.lb_key}/${each.value.probe_name}"
  ].id
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes
  floating_ip_enabled     = each.value.floating_ip_enabled
  disable_outbound_snat   = each.value.disable_outbound_snat
  load_distribution       = each.value.load_distribution
}
