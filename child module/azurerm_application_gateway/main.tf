resource "azurerm_application_gateway" "this" {
  for_each = var.application_gateways

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  tags                = each.value.tags

  sku {
    name     = each.value.sku_name
    tier     = each.value.sku_tier
    capacity = each.value.capacity
  }

  gateway_ip_configuration {
    name      = "${each.value.name}-gateway-ip"
    subnet_id = each.value.subnet_id
  }

  frontend_ip_configuration {
    name                          = "${each.value.name}-frontend"
    subnet_id                     = each.value.private_ip_address == null ? null : each.value.subnet_id
    private_ip_address            = each.value.private_ip_address
    private_ip_address_allocation = each.value.private_ip_address == null ? null : "Static"
    public_ip_address_id          = each.value.public_ip_address_id
  }

  frontend_port {
    name = "${each.value.name}-frontend-port"
    port = each.value.frontend_port
  }

  backend_address_pool {
    name         = "${each.value.name}-backend-pool"
    ip_addresses = each.value.backend_addresses
  }

  backend_http_settings {
    name                  = "${each.value.name}-backend-settings"
    cookie_based_affinity = "Disabled"
    port                  = each.value.backend_port
    protocol              = each.value.backend_protocol
    request_timeout       = each.value.request_timeout
    probe_name            = each.value.probe == null ? null : each.value.probe.name
  }

  http_listener {
    name                           = "${each.value.name}-listener"
    frontend_ip_configuration_name = "${each.value.name}-frontend"
    frontend_port_name             = "${each.value.name}-frontend-port"
    protocol                       = each.value.listener_protocol
  }

  request_routing_rule {
    name                       = "${each.value.name}-routing-rule"
    priority                   = each.value.priority
    rule_type                  = "Basic"
    http_listener_name         = "${each.value.name}-listener"
    backend_address_pool_name  = "${each.value.name}-backend-pool"
    backend_http_settings_name = "${each.value.name}-backend-settings"
  }

  dynamic "probe" {
    for_each = each.value.probe == null ? [] : [each.value.probe]
    content {
      name                                      = probe.value.name
      protocol                                  = probe.value.protocol
      path                                      = probe.value.path
      host                                      = probe.value.host
      pick_host_name_from_backend_http_settings = probe.value.host == null
      interval                                  = probe.value.interval
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
    }
  }
}
