# ============================================================
# Azure Monitor Metric Alert Outputs
# ============================================================

output "monitor_alert" {
  description = "Details of the created Azure Monitor Metric Alerts"

  value = {
    for key, alert in azurerm_monitor_metric_alert.monitor_alert :
    key => {
      id       = alert.id
      name     = alert.name
      severity = alert.severity
      enabled  = alert.enabled
    }
  }
}