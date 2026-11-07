variable "private_endpoints" {
  description = "Private endpoints keyed by a stable identifier."
  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    subnet_id                       = string
    private_connection_resource_id  = string
    subresource_names               = list(string)
    private_service_connection_name = optional(string)
    is_manual_connection            = optional(bool, false)
    request_message                 = optional(string)
    private_dns_zone_ids            = optional(list(string), [])
    private_dns_zone_group_name     = optional(string, "default")
    tags                            = optional(map(string), {})
  }))
  default = {}
}
