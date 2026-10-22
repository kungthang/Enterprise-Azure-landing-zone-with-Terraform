# ============================================================
# Azure RBAC Role Assignment Variables
# ============================================================

variable "role_assignment" {
  description = "Configuration for Azure RBAC Role Assignments"

  type = map(object({
    scope                            = string
    role_definition_name             = string
    principal_id                     = string
    principal_type                   = string
    skip_service_principal_aad_check = bool
    description                      = string
  }))

  validation {
    condition = alltrue([
      for assignment in var.role_assignment :
      contains(
        [
          "ServicePrincipal",
          "User",
          "Group",
          "ForeignGroup",
          "Device"
        ],
        assignment.principal_type
      )
    ])

    error_message = "principal_type must be ServicePrincipal, User, Group, ForeignGroup, or Device."
  }

  validation {
    condition = alltrue([
      for assignment in var.role_assignment :
      contains(
        [
          "Key Vault Secrets User",
          "Storage Blob Data Contributor"
        ],
        assignment.role_definition_name
      )
    ])

    error_message = "Only the approved least-privilege Key Vault and Storage roles can be assigned by this module."
  }
}