variable "vms" {
  description = "Linux virtual machines and their network configuration, keyed by a stable identifier."
  type = map(object({
    subnet_id            = string
    resource_group_name  = string
    pip_name             = optional(string)
    allocation_method    = optional(string, "Static")
    sku                  = optional(string, "Standard")
    nics_name            = string
    internal_ip          = string
    private_ip_address   = optional(string)
    vm_name              = string
    size                 = string
    admin_username       = string
    admin_password       = string
    caching              = string
    storage_account_type = string
    publisher            = string
    offer                = string
    image_sku            = string
    version              = string
    location             = string
    custom_data          = optional(string)
  }))
  default = {}

  validation {
    condition = alltrue([
      for vm in values(var.vms) :
      contains(["dynamic", "static", "internal"], lower(vm.internal_ip)) &&
      (vm.private_ip_address == null || lower(vm.internal_ip) == "static") &&
      (lower(vm.internal_ip) != "static" || vm.private_ip_address != null)
    ])
    error_message = "Each VM internal_ip must be Dynamic, Static, or internal (for dynamic allocation); Static allocation requires private_ip_address, and that address cannot be set with dynamic allocation."
  }
}
