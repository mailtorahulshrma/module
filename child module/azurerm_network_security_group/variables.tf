variable "nsgs" {
  description = "Network security groups keyed by a stable identifier."
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    subnet_ids          = optional(list(string), [])
    tags                = optional(map(string), {})
    security_rules = optional(map(object({
      name                         = string
      priority                     = number
      direction                    = string
      access                       = string
      protocol                     = string
      source_port_range            = optional(string)
      source_port_ranges           = optional(list(string))
      destination_port_range       = optional(string)
      destination_port_ranges      = optional(list(string))
      source_address_prefix        = optional(string)
      source_address_prefixes      = optional(list(string))
      destination_address_prefix   = optional(string)
      destination_address_prefixes = optional(list(string))
      description                  = optional(string)
    })), {})
  }))
  default = {}
}