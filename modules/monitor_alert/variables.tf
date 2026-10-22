# ============================================================
# Azure Monitor Metric Alert Variables
# ============================================================

variable "monitor_alert" {
  description = "Configuration for Azure Monitor Metric Alerts"

  type = map(object({
    name                = string
    resource_group_name = string
    target_resource_id  = string

    description = string
    severity    = number
    enabled     = bool

    frequency     = string
    window_size   = string
    auto_mitigate = bool

    metric_namespace = string
    metric_name      = string
    aggregation      = string
    operator         = string
    threshold        = number

    action_group_id = string
    tags            = map(string)
  }))

  validation {
    condition = alltrue([
      for alert in var.monitor_alert :
      alert.severity >= 0 && alert.severity <= 4
    ])

    error_message = "Alert severity must be between 0 and 4."
  }

  validation {
    condition = alltrue([
      for alert in var.monitor_alert :
      contains(
        [
          "Average",
          "Minimum",
          "Maximum",
          "Total",
          "Count"
        ],
        alert.aggregation
      )
    ])

    error_message = "Aggregation must be Average, Minimum, Maximum, Total, or Count."
  }

  validation {
    condition = alltrue([
      for alert in var.monitor_alert :
      contains(
        [
          "Equals",
          "NotEquals",
          "GreaterThan",
          "GreaterThanOrEqual",
          "LessThan",
          "LessThanOrEqual"
        ],
        alert.operator
      )
    ])

    error_message = "The metric-alert operator is invalid."
  }

  validation {
    condition = alltrue([
      for alert in var.monitor_alert :
      contains(
        [
          "PT1M",
          "PT5M",
          "PT15M",
          "PT30M",
          "PT1H"
        ],
        alert.frequency
      )
    ])

    error_message = "Alert frequency must be PT1M, PT5M, PT15M, PT30M, or PT1H."
  }

  validation {
    condition = alltrue([
      for alert in var.monitor_alert :
      contains(
        [
          "PT1M",
          "PT5M",
          "PT15M",
          "PT30M",
          "PT1H",
          "PT6H",
          "PT12H",
          "P1D"
        ],
        alert.window_size
      )
    ])

    error_message = "The selected alert window_size is invalid."
  }
}