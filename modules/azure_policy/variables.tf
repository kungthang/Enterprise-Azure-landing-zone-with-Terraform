# ============================================================
# Azure Policy Assignment Variables
# ============================================================

variable "azure_policy" {
  description = "Configuration for Azure resource-group policy assignments"

  type = map(object({
    name                   = string
    display_name           = string
    description            = string
    resource_group_id      = string
    policy_definition_id   = string
    enforce                = bool
    parameters             = map(any)
    metadata               = map(string)
    non_compliance_message = string
  }))

  validation {
    condition = alltrue([
      for assignment in var.azure_policy :
      length(assignment.name) <= 64
    ])

    error_message = "Azure Policy assignment names must not exceed 64 characters."
  }

  validation {
    condition = alltrue([
      for assignment in var.azure_policy :
      length(assignment.policy_definition_id) > 0
    ])

    error_message = "Every Azure Policy assignment must contain a policy definition ID."
  }

  validation {
    condition = alltrue([
      for assignment in var.azure_policy :
      length(assignment.non_compliance_message) > 0
    ])

    error_message = "Every Azure Policy assignment must contain a noncompliance message."
  }
}