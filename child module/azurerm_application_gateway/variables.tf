variable "application_gateways" {
  description = "Application Gateways keyed by a stable identifier."
  type = map(object({
    name                 = string
    location             = string
    resource_group_name  = string
    subnet_id            = string
    private_ip_address   = optional(string)
    public_ip_address_id = optional(string)
    public_ip_name       = optional(string)
    backend_addresses    = list(string)
    sku_name             = optional(string, "Standard_v2")
    sku_tier             = optional(string, "Standard_v2")
    capacity             = optional(number, 2)
    frontend_port        = optional(number, 80)
    backend_port         = optional(number, 80)
    backend_protocol     = optional(string, "Http")
    listener_protocol    = optional(string, "Http")
    request_timeout      = optional(number, 30)
    priority             = optional(number, 100)
    tags                 = optional(map(string), {})
    probe = optional(object({
      name                = string
      protocol            = string
      path                = string
      host                = optional(string)
      interval            = optional(number, 30)
      timeout             = optional(number, 30)
      unhealthy_threshold = optional(number, 3)
    }))
  }))
  default = {}

  validation {
    condition = alltrue([
      for gateway in values(var.application_gateways) :
      (gateway.private_ip_address != null ? 1 : 0) +
      (gateway.public_ip_address_id != null ? 1 : 0) +
      (gateway.public_ip_name != null ? 1 : 0) == 1
    ])
    error_message = "Each Application Gateway must configure exactly one of private_ip_address, public_ip_address_id, or public_ip_name."
  }
}
