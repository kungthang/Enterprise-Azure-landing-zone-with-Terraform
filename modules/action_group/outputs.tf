output "action_group" {
  description = "Details of the created Azure Monitor Action Groups"

  value = {
    for key, action_group in azurerm_monitor_action_group.action_group :
    key => {
      id         = action_group.id
      name       = action_group.name
      short_name = action_group.short_name
    }
  }
}