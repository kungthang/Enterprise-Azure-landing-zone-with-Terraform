variable "log_analytics" {
  description = "Configuration for Azure Log Analytics Workspaces"

  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    sku                             = string
    retention_in_days               = number
    daily_quota_gb                  = number
    local_authentication_enabled    = bool
    internet_ingestion_access_type  = string
    internet_query_access_type      = string
    allow_resource_only_permissions = bool
    tags                            = map(string)
  }))

  validation {
    condition = alltrue([
      for workspace in var.log_analytics :
      workspace.retention_in_days >= 30 &&
      workspace.retention_in_days <= 730
    ])

    error_message = "Log Analytics retention must be between 30 and 730 days."
  }

  validation {
    condition = alltrue([
      for workspace in var.log_analytics :
      workspace.sku == "PerGB2018"
    ])

    error_message = "The Log Analytics SKU must remain PerGB2018."
  }

  validation {
    condition = alltrue([
      for workspace in var.log_analytics :
      contains(
        ["Enabled", "Disabled", "SecuredByPerimeter"],
        workspace.internet_ingestion_access_type
      )
    ])

    error_message = "internet_ingestion_access_type must be Enabled, Disabled, or SecuredByPerimeter."
  }

  validation {
    condition = alltrue([
      for workspace in var.log_analytics :
      contains(
        ["Enabled", "Disabled", "SecuredByPerimeter"],
        workspace.internet_query_access_type
      )
    ])

    error_message = "internet_query_access_type must be Enabled, Disabled, or SecuredByPerimeter."
  }
}