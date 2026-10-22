variable "storage_account" {
  description = "Configuration for Azure Storage Accounts"

  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    account_kind                    = string
    account_tier                    = string
    account_replication_type        = string
    access_tier                     = string
    https_traffic_only_enabled      = bool
    min_tls_version                 = string
    public_network_access           = string
    allow_nested_items_to_be_public = bool
    shared_access_key_enabled       = bool
    default_to_oauth_authentication = bool
    tags                            = map(string)
  }))

  validation {
    condition = alltrue([
      for storage_account in var.storage_account :
      contains(
        ["Enabled", "Disabled"],
        storage_account.public_network_access
      )
    ])

    error_message = "public_network_access must be Enabled or Disabled."
  }
}