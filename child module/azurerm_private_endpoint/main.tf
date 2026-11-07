resource "azurerm_private_endpoint" "this" {
  for_each = var.private_endpoints

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  subnet_id           = each.value.subnet_id
  tags                = each.value.tags

  private_service_connection {
    name                           = coalesce(each.value.private_service_connection_name, "${each.value.name}-connection")
    private_connection_resource_id = each.value.private_connection_resource_id
    subresource_names              = each.value.subresource_names
    is_manual_connection           = each.value.is_manual_connection
    request_message                = each.value.request_message
  }

  dynamic "private_dns_zone_group" {
    for_each = length(each.value.private_dns_zone_ids) > 0 ? [each.value.private_dns_zone_ids] : []
    content {
      name                 = each.value.private_dns_zone_group_name
      private_dns_zone_ids = private_dns_zone_group.value
    }
  }
}
