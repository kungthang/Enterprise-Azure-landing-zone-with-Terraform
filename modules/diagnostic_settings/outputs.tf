# ============================================================
# Azure Monitor Diagnostic Setting Outputs
# ============================================================

output "diagnostic_setting" {
  description = "Details of the created Azure Monitor Diagnostic Settings"

  value = {
    for key, diagnostic_setting in azurerm_monitor_diagnostic_setting.diagnostic_setting :
    key => {
      id   = diagnostic_setting.id
      name = diagnostic_setting.name
    }
  }
}