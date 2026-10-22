# ============================================================
# Azure Monitor Diagnostic Settings
# ============================================================

resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  for_each = var.diagnostic_setting

  name               = each.value.name
  target_resource_id = each.value.target_resource_id

  log_analytics_workspace_id = each.value.log_analytics_workspace_id

  log_analytics_destination_type = each.value.log_analytics_destination_type

  # ----------------------------------------------------------
  # Log category groups
  #
  # Example:
  # allLogs
  # audit
  # ----------------------------------------------------------

  dynamic "enabled_log" {
    for_each = each.value.log_category_groups

    content {
      category_group = enabled_log.value
    }
  }

  # ----------------------------------------------------------
  # Individual log categories
  #
  # Used only when a resource does not support the desired
  # category group or when specific categories are preferred.
  # ----------------------------------------------------------

  dynamic "enabled_log" {
    for_each = each.value.log_categories

    content {
      category = enabled_log.value
    }
  }

  # ----------------------------------------------------------
  # Metric categories
  #
  # Most Azure resources use:
  # AllMetrics
  # ----------------------------------------------------------

  dynamic "enabled_metric" {
    for_each = each.value.metric_categories

    content {
      category = enabled_metric.value
    }
  }
}