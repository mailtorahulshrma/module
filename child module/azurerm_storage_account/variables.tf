variable "storage_accounts" {
  description = "Storage accounts keyed by a stable identifier."
  type = map(object({
    name                            = string
    resource_group_name             = string
    location                        = string
    account_tier                    = string
    account_replication_type        = string
    account_kind                    = optional(string, "StorageV2")
    min_tls_version                 = optional(string, "TLS1_2")
    https_traffic_only_enabled      = optional(bool, true)
    public_network_access           = optional(string)
    public_network_access_enabled   = optional(bool)
    allow_nested_items_to_be_public = optional(bool, false)
    tags                            = optional(map(string), {})
  }))
  default = {}

  validation {
    condition = alltrue([
      for account in values(var.storage_accounts) :
      (account.public_network_access == null || contains(["Enabled", "Disabled", "SecuredByPerimeter"], account.public_network_access)) &&
      !(account.public_network_access != null && account.public_network_access_enabled != null)
    ])
    error_message = "Set either public_network_access to Enabled, Disabled, or SecuredByPerimeter, or use the legacy public_network_access_enabled boolean; do not set both."
  }
}
