# ============================================================
# Azure Log Analytics Workspace Outputs
# ============================================================

output "log_analytics" {
  description = "Details of the created Azure Log Analytics Workspaces"

  value = {
    for key, workspace in azurerm_log_analytics_workspace.log_analytics :
    key => {
      id           = workspace.id
      name         = workspace.name
      workspace_id = workspace.workspace_id
    }
  }
}