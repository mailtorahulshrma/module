variable "bastions" {
  description = "Azure Bastion hosts keyed by a stable identifier."
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    subnet_id           = string
    public_ip_name      = string
    sku                 = optional(string, "Standard")
    scale_units         = optional(number, 2)
    tags                = optional(map(string), {})
  }))
  default = {}
}
