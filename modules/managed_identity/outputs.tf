# ============================================================
# Azure User-Assigned Managed Identity Outputs
# ============================================================

output "managed_identity" {
  description = "Details of the created Azure User-Assigned Managed Identities"

  value = {
    for key, identity in azurerm_user_assigned_identity.managed_identity :
    key => {
      id           = identity.id
      name         = identity.name
      client_id    = identity.client_id
      principal_id = identity.principal_id
      tenant_id    = identity.tenant_id
    }
  }
}