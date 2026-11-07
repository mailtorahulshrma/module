variable "nat_gateways" {
  description = "NAT gateways and the subnets that use them, keyed by a stable identifier."
  type = map(object({
    name                    = string
    location                = string
    resource_group_name     = string
    public_ip_name          = string
    subnet_ids              = list(string)
    sku_name                = optional(string, "Standard")
    idle_timeout_in_minutes = optional(number, 10)
    tags                    = optional(map(string), {})
  }))
  default = {}
}
