variable "private_dns_zones" {
  description = "Private DNS zones keyed by a stable identifier, with optional VNet links."
  type = map(object({
    name                = string
    resource_group_name = string
    tags                = optional(map(string), {})
    virtual_network_links = optional(map(object({
      name                 = string
      virtual_network_id   = string
      registration_enabled = optional(bool, false)
      tags                 = optional(map(string), {})
    })), {})
  }))
  default = {}
}