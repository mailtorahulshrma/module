variable "load_balancers" {
  description = "Internal load balancers keyed by a stable identifier."
  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
    subnet_id                   = string
    frontend_private_ip_address = string
    backend_pool_name           = string
    sku                         = optional(string, "Standard")
    tags                        = optional(map(string), {})
    backend_nics = optional(map(object({
      network_interface_id  = string
      ip_configuration_name = optional(string, "internal")
    })), {})
    probes = optional(map(object({
      name         = string
      protocol     = string
      port         = number
      request_path = optional(string)
    })), {})
    rules = optional(map(object({
      name                    = string
      protocol                = string
      frontend_port           = number
      backend_port            = number
      probe_name              = optional(string)
      idle_timeout_in_minutes = optional(number, 4)
      floating_ip_enabled     = optional(bool, false)
      disable_outbound_snat   = optional(bool, false)
      load_distribution       = optional(string, "Default")
    })), {})
  }))
  default = {}
}
