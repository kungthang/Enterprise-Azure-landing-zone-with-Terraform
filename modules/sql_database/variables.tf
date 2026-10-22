# ============================================================
# Azure SQL Database Variables
# ============================================================

variable "sql_database" {
  description = "Configuration for Azure SQL Databases"

  type = map(object({
    name                                = string
    server_id                           = string
    collation                           = string
    sku_name                            = string
    max_size_gb                         = number
    zone_redundant                      = bool
    read_scale                          = bool
    storage_account_type                = string
    transparent_data_encryption_enabled = bool
    tags                                = map(string)
  }))

  validation {
    condition = alltrue([
      for sql_database in var.sql_database :
      sql_database.transparent_data_encryption_enabled == true
    ])

    error_message = "Transparent Data Encryption must remain enabled for every Azure SQL Database."
  }
}