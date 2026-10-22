# ============================================================
# Azure Monitor Diagnostic Setting Variables
# ============================================================

variable "diagnostic_setting" {
  description = "Configuration for Azure Monitor Diagnostic Settings"

  type = map(object({
    name                           = string
    target_resource_id             = string
    log_analytics_workspace_id     = string
    log_analytics_destination_type = string
    log_category_groups            = set(string)
    log_categories                 = set(string)
    metric_categories              = set(string)
  }))

  validation {
    condition = alltrue([
      for setting in var.diagnostic_setting :
      contains(
        ["AzureDiagnostics", "Dedicated"],
        setting.log_analytics_destination_type
      )
    ])

    error_message = "log_analytics_destination_type must be AzureDiagnostics or Dedicated."
  }

  validation {
    condition = alltrue([
      for setting in var.diagnostic_setting :
      length(setting.log_category_groups) > 0 ||
      length(setting.log_categories) > 0 ||
      length(setting.metric_categories) > 0
    ])

    error_message = "Every diagnostic setting must enable at least one log category group, log category, or metric category."
  }
}