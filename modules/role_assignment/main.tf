# ============================================================
# Azure RBAC Role Assignments
# ============================================================

resource "azurerm_role_assignment" "role_assignment" {
  for_each = var.role_assignment

  scope                = each.value.scope
  role_definition_name = each.value.role_definition_name
  principal_id         = each.value.principal_id
  principal_type       = each.value.principal_type

  skip_service_principal_aad_check = each.value.skip_service_principal_aad_check

  description = each.value.description
}