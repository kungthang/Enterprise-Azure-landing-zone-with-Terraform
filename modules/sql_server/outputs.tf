# ============================================================
# Azure SQL Logical Server Outputs
# ============================================================

output "sql_server" {
  description = "Details of the created Azure SQL logical servers"

  value = {
    for key, sql_server in azurerm_mssql_server.sql_server :
    key => {
      id                          = sql_server.id
      name                        = sql_server.name
      fully_qualified_domain_name = sql_server.fully_qualified_domain_name
    }
  }
}