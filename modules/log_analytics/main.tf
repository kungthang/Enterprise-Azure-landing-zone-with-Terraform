# ============================================================
# Azure Log Analytics Workspaces
# ============================================================

resource "azurerm_log_analytics_workspace" "log_analytics" {
  for_each = var.log_analytics

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  sku               = each.value.sku
  retention_in_days = each.value.retention_in_days
  daily_quota_gb    = each.value.daily_quota_gb

  local_authentication_enabled    = each.value.local_authentication_enabled
  allow_resource_only_permissions = each.value.allow_resource_only_permissions

  internet_ingestion_access_type = each.value.internet_ingestion_access_type
  internet_query_access_type     = each.value.internet_query_access_type

  tags = each.value.tags
}