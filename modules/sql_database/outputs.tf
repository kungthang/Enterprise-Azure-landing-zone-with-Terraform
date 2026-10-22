# ============================================================
# Azure SQL Database Outputs
# ============================================================

output "sql_database" {
  description = "Details of the created Azure SQL Databases"

  value = {
    for key, sql_database in azurerm_mssql_database.sql_database :
    key => {
      id        = sql_database.id
      name      = sql_database.name
      server_id = sql_database.server_id
    }
  }
}