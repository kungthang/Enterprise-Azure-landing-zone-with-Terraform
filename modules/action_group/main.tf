resource "azurerm_monitor_action_group" "action_group" {
  for_each = var.action_group

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  short_name          = each.value.short_name

  dynamic "email_receiver" {
    for_each = each.value.email_receivers

    content {
      name                    = email_receiver.value.name
      email_address           = email_receiver.value.email_address
      use_common_alert_schema = email_receiver.value.use_common_alert_schema
    }
  }

  tags = each.value.tags
}