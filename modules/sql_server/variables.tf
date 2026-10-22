# ============================================================
# Azure SQL Logical Server Configuration
# ============================================================

variable "sql_server" {
  description = "Non-sensitive configuration for Azure SQL logical servers"

  type = map(object({
    name                                 = string
    location                             = string
    resource_group_name                  = string
    version                              = string
    administrator_login                  = string
    minimum_tls_version                  = string
    public_network_access_enabled        = bool
    azuread_administrator_login_username = string
    azuread_administrator_object_id      = string
    azuread_administrator_tenant_id      = string
    azuread_authentication_only          = bool
    tags                                 = map(string)
  }))

  validation {
    condition = alltrue([
      for sql_server in var.sql_server :
      sql_server.public_network_access_enabled == false
    ])

    error_message = "Public network access must remain disabled for every Azure SQL Server."
  }

  validation {
    condition = alltrue([
      for sql_server in var.sql_server :
      sql_server.minimum_tls_version == "1.2"
    ])

    error_message = "The minimum TLS version must remain 1.2 for every Azure SQL Server."
  }
}


# ============================================================
# Azure SQL Administrator Passwords
# ============================================================

variable "sql_administrator_passwords" {
  description = "Sensitive administrator password map for Azure SQL logical servers"

  type      = map(string)
  sensitive = true

  validation {
    condition = alltrue([
      for key in keys(var.sql_server) :
      contains(keys(var.sql_administrator_passwords), key)
    ])

    error_message = "A SQL administrator password must be supplied for every SQL Server key."
  }
}