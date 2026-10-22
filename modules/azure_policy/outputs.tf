# ============================================================
# Azure Policy Assignment Outputs
# ============================================================

output "azure_policy" {
  description = "Details of the created Azure Policy assignments"

  value = {
    for key, assignment in azurerm_resource_group_policy_assignment.azure_policy :
    key => {
      id                   = assignment.id
      name                 = assignment.name
      display_name         = assignment.display_name
      resource_group_id    = assignment.resource_group_id
      policy_definition_id = assignment.policy_definition_id
      enforce              = assignment.enforce
    }
  }
}