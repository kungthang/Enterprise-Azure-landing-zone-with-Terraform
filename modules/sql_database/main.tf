# ============================================================
# Azure SQL Databases
# ============================================================

resource "azurerm_mssql_database" "sql_database" {
  for_each = var.sql_database

  name      = each.value.name
  server_id = each.value.server_id

  collation   = each.value.collation
  sku_name    = each.value.sku_name
  max_size_gb = each.value.max_size_gb

  zone_redundant       = each.value.zone_redundant
  read_scale           = each.value.read_scale
  storage_account_type = each.value.storage_account_type

  transparent_data_encryption_enabled = each.value.transparent_data_encryption_enabled

  tags = each.value.tags

  lifecycle {
    prevent_destroy = false
  }
}