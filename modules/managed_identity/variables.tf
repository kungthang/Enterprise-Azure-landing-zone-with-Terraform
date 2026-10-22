# ============================================================
# Azure User-Assigned Managed Identity Variables
# ============================================================

variable "managed_identity" {
  description = "Configuration for Azure User-Assigned Managed Identities"

  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    tags                = map(string)
  }))
}