variable "key_vault" {
  description = "Configuration for Azure Key Vaults"

  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    sku_name                      = string
    soft_delete_retention_days    = number
    purge_protection_enabled      = bool
    rbac_authorization_enabled    = bool
    public_network_access_enabled = bool
    tags                          = map(string)
  }))
}