# ============================================================
# Azure RBAC Role Assignment Outputs
# ============================================================

output "role_assignment" {
  description = "Details of the created Azure RBAC Role Assignments"

  value = {
    for key, assignment in azurerm_role_assignment.role_assignment :
    key => {
      id                   = assignment.id
      name                 = assignment.name
      scope                = assignment.scope
      principal_id         = assignment.principal_id
      role_definition_name = assignment.role_definition_name
    }
  }
}