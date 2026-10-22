# ============================================================
# Azure Monitor Metric Alerts
# ============================================================

resource "azurerm_monitor_metric_alert" "monitor_alert" {
  for_each = var.monitor_alert

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  scopes              = [each.value.target_resource_id]

  description = each.value.description
  severity    = each.value.severity
  enabled     = each.value.enabled

  frequency   = each.value.frequency
  window_size = each.value.window_size

  auto_mitigate = each.value.auto_mitigate

  criteria {
    metric_namespace = each.value.metric_namespace
    metric_name      = each.value.metric_name
    aggregation      = each.value.aggregation
    operator         = each.value.operator
    threshold        = each.value.threshold
  }

  action {
    action_group_id = each.value.action_group_id
  }

  tags = each.value.tags
}