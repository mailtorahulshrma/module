variable "vms" {
  description = "Linux virtual machines and their network configuration, keyed by a stable identifier."
  type = map(object({
    subnet_name          = string
    virtual_network_name = string
    resource_group_name  = string
    pip_name             = string
    allocation_method    = string
    sku                  = string
    nics_name            = string
    internal_ip          = string
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
  }))
  default = {}

  validation {
    condition = alltrue([
      for vm in values(var.vms) :
      contains(["dynamic", "static", "internal"], lower(vm.internal_ip))
    ])
    error_message = "Each VM internal_ip must be Dynamic, Static, or internal (for dynamic allocation)."
  }
}
