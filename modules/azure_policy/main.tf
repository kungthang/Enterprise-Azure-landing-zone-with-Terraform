# ============================================================
# Azure Resource Group Policy Assignments
# ============================================================

resource "azurerm_resource_group_policy_assignment" "azure_policy" {
  for_each = var.azure_policy

  name                 = each.value.name
  display_name         = each.value.display_name
  description          = each.value.description
  resource_group_id    = each.value.resource_group_id
  policy_definition_id = each.value.policy_definition_id

  enforce = each.value.enforce

  parameters = jsonencode(
    each.value.parameters
  )

  metadata = jsonencode(
    each.value.metadata
  )

  non_compliance_message {
    content = each.value.non_compliance_message
  }
}