# ============================================================
# Azure SQL Logical Servers
# ============================================================

resource "azurerm_mssql_server" "sql_server" {
  for_each = var.sql_server

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  version = each.value.version

  administrator_login = each.value.administrator_login

  # Retrieve the password from the separate sensitive map
  # using the current SQL Server key: prod or dev.
  administrator_login_password = var.sql_administrator_passwords[
    each.key
  ]

  minimum_tls_version = each.value.minimum_tls_version

  # No public SQL network access
  public_network_access_enabled = each.value.public_network_access_enabled

  azuread_administrator {
    login_username              = each.value.azuread_administrator_login_username
    object_id                   = each.value.azuread_administrator_object_id
    tenant_id                   = each.value.azuread_administrator_tenant_id
    azuread_authentication_only = each.value.azuread_authentication_only
  }

  tags = each.value.tags
}