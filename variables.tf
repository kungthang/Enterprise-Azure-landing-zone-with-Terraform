# ============================================================
# Azure Subscription
# ============================================================

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
  sensitive   = true
}


# ============================================================
# Resource Groups
# ============================================================

variable "resource_group" {
  description = "Configuration for Azure resource groups"

  type = map(object({
    name     = string
    location = string
  }))
}


# ============================================================
# Virtual Networks
# ============================================================

variable "virtual_network" {
  description = "Configuration for Azure virtual networks"

  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    virtual_network_address_space = list(string)
  }))
}


# ============================================================
# Subnets
# ============================================================

variable "subnet" {
  description = "Configuration for Azure subnets"

  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    address_prefixes     = list(string)
  }))
}


# ============================================================
# Virtual Network Peerings
# ============================================================

variable "vnet_peering" {
  description = "Configuration for virtual network peerings"

  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    remote_vnet_key      = string
  }))
}


# ============================================================
# Network Security Groups
# ============================================================

variable "network_security_group" {
  description = "Configuration for network security groups"

  type = map(object({
    name               = string
    resource_group_key = string
  }))
}


# ============================================================
# Network Security Rules
# ============================================================

variable "network_security_rule" {
  description = "Configuration for network security rules"

  type = map(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    resource_group_key         = string
    network_security_group_key = string
  }))
}


# ============================================================
# Public IP Addresses
# ============================================================

variable "public_ip" {
  description = "Configuration for Azure public IP addresses"

  type = map(object({
    name               = string
    resource_group_key = string
    allocation_method  = string
    sku                = string
  }))
}


# ============================================================
# Azure Firewall
# ============================================================

variable "azure_firewall" {
  description = "Configuration for Azure Firewall"

  type = map(object({
    name                  = string
    resource_group_key    = string
    sku_name              = string
    sku_tier              = string
    ip_configuration_name = string
    public_ip_key         = string
  }))
}

# ============================================================
# Route Tables
# ============================================================

variable "route_table" {
  description = "Configuration for Azure route tables"

  type = map(object({
    name                          = string
    resource_group_key            = string
    bgp_route_propagation_enabled = bool
    route_name                    = string
    address_prefix                = string
    next_hop_type                 = string
  }))
}


# ============================================================
# Route Table Associations
# ============================================================

variable "route_table_association" {
  description = "Configuration for route-table-to-subnet associations"

  type = map(object({
    subnet_key      = string
    route_table_key = string
  }))
}

# ============================================================
# Azure Bastion Public IP
# ============================================================

variable "bastion_public_ip" {
  description = "Configuration for Azure Bastion public IP addresses"

  type = map(object({
    name               = string
    resource_group_key = string
    allocation_method  = string
    sku                = string
    tags               = map(string)
  }))
}


# ============================================================
# Azure Bastion Host
# ============================================================

variable "azure_bastion" {
  description = "Configuration for Azure Bastion hosts"

  type = map(object({
    name                  = string
    resource_group_key    = string
    sku                   = string
    copy_paste_enabled    = bool
    file_copy_enabled     = bool
    ip_configuration_name = string
    public_ip_key         = string
    tags                  = map(string)
  }))
}

# ============================================================
# VPN Gateway Public IP
# ============================================================

variable "vpn_gateway_public_ip" {
  description = "Configuration for VPN Gateway public IP addresses"

  type = map(object({
    name               = string
    resource_group_key = string
    allocation_method  = string
    sku                = string
  }))
}


# ============================================================
# VPN Gateway
# ============================================================

variable "vpn_gateway" {
  description = "Configuration for Azure VPN Gateway"

  type = map(object({
    name                          = string
    resource_group_key            = string
    type                          = string
    vpn_type                      = string
    sku                           = string
    active_active                 = bool
    bgp_enabled                   = bool
    ip_configuration_name         = string
    private_ip_address_allocation = string
    public_ip_key                 = string
  }))
}

# ============================================================
# Application Gateway Public IP
# ============================================================

variable "application_gateway_public_ip" {
  description = "Configuration for Application Gateway public IP addresses"

  type = map(object({
    name               = string
    resource_group_key = string
    allocation_method  = string
    sku                = string
    zones              = list(string)
  }))
}


# ============================================================
# Application Gateway WAF Policy
# ============================================================

variable "application_gateway_waf_policy" {
  description = "Configuration for Application Gateway WAF policies"

  type = map(object({
    name                        = string
    resource_group_key          = string
    enabled                     = bool
    mode                        = string
    request_body_check          = bool
    file_upload_limit_in_mb     = number
    max_request_body_size_in_kb = number
    managed_rule_set_type       = string
    managed_rule_set_version    = string
  }))
}


# ============================================================
# Application Gateway
# ============================================================

variable "application_gateway" {
  description = "Configuration for Application Gateway WAF v2"

  type = map(object({
    name                           = string
    resource_group_key             = string
    zones                          = list(string)
    sku_name                       = string
    sku_tier                       = string
    autoscale_min_capacity         = number
    autoscale_max_capacity         = number
    gateway_ip_configuration_name  = string
    frontend_ip_configuration_name = string
    frontend_port_name             = string
    frontend_port                  = number
    backend_address_pool_name      = string
    backend_http_settings_name     = string
    backend_protocol               = string
    backend_port                   = number
    cookie_based_affinity          = string
    request_timeout                = number
    http_listener_name             = string
    listener_protocol              = string
    request_routing_rule_name      = string
    routing_rule_type              = string
    routing_rule_priority          = number
    public_ip_key                  = string
    waf_policy_key                 = string
  }))
}

# ============================================================
# Azure Key Vault
# ============================================================

variable "key_vault" {
  description = "Configuration for Azure Key Vaults"

  type = map(object({
    name                          = string
    resource_group_key            = string
    sku_name                      = string
    soft_delete_retention_days    = number
    purge_protection_enabled      = bool
    rbac_authorization_enabled    = bool
    public_network_access_enabled = bool
    tags                          = map(string)
  }))
}

variable "storage_account" {
  description = "Configuration for Azure Storage Accounts"

  type = map(object({
    name                            = string
    resource_group_key              = string
    account_kind                    = string
    account_tier                    = string
    account_replication_type        = string
    access_tier                     = string
    https_traffic_only_enabled      = bool
    min_tls_version                 = string
    public_network_access           = string
    allow_nested_items_to_be_public = bool
    shared_access_key_enabled       = bool
    default_to_oauth_authentication = bool
    tags                            = map(string)
  }))

  validation {
    condition = alltrue([
      for storage_account in var.storage_account :
      storage_account.public_network_access == "Disabled"
    ])

    error_message = "Public network access must remain Disabled for all Storage Accounts."
  }
}

# ============================================================
# Azure SQL Logical Servers
# ============================================================

variable "sql_server" {
  description = "Non-sensitive configuration for Azure SQL logical servers"

  type = map(object({
    name                                 = string
    resource_group_key                   = string
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
  description = "Administrator passwords for Azure SQL logical servers"

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

# ============================================================
# Azure SQL Databases
# ============================================================

variable "sql_database" {
  description = "Configuration for Azure SQL Databases"

  type = map(object({
    name                                = string
    sql_server_key                      = string
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

# ============================================================
# Azure Private DNS Zones
# ============================================================

variable "private_dns_zone" {
  description = "Configuration for Azure Private DNS Zones"

  type = map(object({
    name               = string
    resource_group_key = string
    tags               = map(string)
  }))
}

# ============================================================
# Private DNS Zone VNet Links
# ============================================================

variable "private_dns_zone_vnet_link" {
  description = "Configuration for Private DNS Zone Virtual Network Links"

  type = map(object({
    name                 = string
    private_dns_zone_key = string
    virtual_network_key  = string
    registration_enabled = bool
    tags                 = map(string)
  }))

  validation {
    condition = alltrue([
      for link in var.private_dns_zone_vnet_link :
      link.registration_enabled == false
    ])

    error_message = "Registration must remain disabled for Private Link DNS zone VNet links."
  }
}

# ============================================================
# Azure Private Endpoints
# ============================================================

variable "private_endpoint" {
  description = "Configuration for Azure Private Endpoints"

  type = map(object({
    name                            = string
    resource_group_key              = string
    subnet_key                      = string
    target_resource_type            = string
    target_resource_key             = string
    private_service_connection_name = string
    subresource_name                = string
    is_manual_connection            = bool
    private_dns_zone_group_name     = string
    private_dns_zone_key            = string
    tags                            = map(string)
  }))

  validation {
    condition = alltrue([
      for private_endpoint in var.private_endpoint :
      contains(
        ["key_vault", "storage_account", "sql_server"],
        private_endpoint.target_resource_type
      )
    ])

    error_message = "target_resource_type must be key_vault, storage_account, or sql_server."
  }

  validation {
    condition = alltrue([
      for private_endpoint in var.private_endpoint :
      contains(
        ["vault", "blob", "sqlServer"],
        private_endpoint.subresource_name
      )
    ])

    error_message = "subresource_name must be vault, blob, or sqlServer."
  }

  validation {
    condition = alltrue([
      for private_endpoint in var.private_endpoint :
      private_endpoint.is_manual_connection == false
    ])

    error_message = "Private Endpoint connections must use automatic approval."
  }
}

# ============================================================
# Azure Log Analytics Workspaces
# ============================================================

variable "log_analytics" {
  description = "Configuration for Azure Log Analytics Workspaces"

  type = map(object({
    name                            = string
    resource_group_key              = string
    sku                             = string
    retention_in_days               = number
    daily_quota_gb                  = number
    local_authentication_enabled    = bool
    internet_ingestion_access_type  = string
    internet_query_access_type      = string
    allow_resource_only_permissions = bool
    tags                            = map(string)
  }))

  validation {
    condition = alltrue([
      for workspace in var.log_analytics :
      workspace.retention_in_days >= 30 &&
      workspace.retention_in_days <= 730
    ])

    error_message = "Log Analytics retention must be between 30 and 730 days."
  }

  validation {
    condition = alltrue([
      for workspace in var.log_analytics :
      workspace.sku == "PerGB2018"
    ])

    error_message = "The Log Analytics SKU must remain PerGB2018."
  }

  validation {
    condition = alltrue([
      for workspace in var.log_analytics :
      contains(
        ["Enabled", "Disabled", "SecuredByPerimeter"],
        workspace.internet_ingestion_access_type
      )
    ])

    error_message = "internet_ingestion_access_type must be Enabled, Disabled, or SecuredByPerimeter."
  }

  validation {
    condition = alltrue([
      for workspace in var.log_analytics :
      contains(
        ["Enabled", "Disabled", "SecuredByPerimeter"],
        workspace.internet_query_access_type
      )
    ])

    error_message = "internet_query_access_type must be Enabled, Disabled, or SecuredByPerimeter."
  }
}

# ============================================================
# Azure Monitor Diagnostic Settings
# ============================================================

variable "diagnostic_setting" {
  description = "Configuration for Azure Monitor Diagnostic Settings"

  type = map(object({
    name                           = string
    target_resource_type           = string
    target_resource_key            = string
    log_category_groups            = set(string)
    log_categories                 = set(string)
    metric_categories              = set(string)
    log_analytics_destination_type = string
  }))

  validation {
    condition = alltrue([
      for setting in var.diagnostic_setting :
      contains(
        [
          "azure_firewall",
          "application_gateway",
          "azure_bastion",
          "vpn_gateway",
          "key_vault",
          "storage_account",
          "sql_server",
          "sql_database"
        ],
        setting.target_resource_type
      )
    ])

    error_message = "target_resource_type must be a supported module resource type."
  }

  validation {
    condition = alltrue([
      for setting in var.diagnostic_setting :
      contains(
        ["AzureDiagnostics", "Dedicated"],
        setting.log_analytics_destination_type
      )
    ])

    error_message = "log_analytics_destination_type must be AzureDiagnostics or Dedicated."
  }

  validation {
    condition = alltrue([
      for setting in var.diagnostic_setting :
      length(setting.log_category_groups) > 0 ||
      length(setting.log_categories) > 0 ||
      length(setting.metric_categories) > 0
    ])

    error_message = "Every diagnostic setting must enable at least one log category group, log category, or metric category."
  }
}

# ============================================================
# Azure Monitor Action Groups
# ============================================================

variable "action_group" {
  description = "Configuration for Azure Monitor Action Groups"

  type = map(object({
    name               = string
    resource_group_key = string
    short_name         = string

    email_receivers = map(object({
      name                    = string
      email_address           = string
      use_common_alert_schema = bool
    }))

    tags = map(string)
  }))
}

# ============================================================
# Azure Monitor Metric Alerts
# ============================================================

variable "monitor_alert" {
  description = "Configuration for Azure Monitor Metric Alerts"

  type = map(object({
    name                 = string
    resource_group_key   = string
    target_resource_type = string
    target_resource_key  = string

    description = string
    severity    = number
    enabled     = bool

    frequency     = string
    window_size   = string
    auto_mitigate = bool

    metric_namespace = string
    metric_name      = string
    aggregation      = string
    operator         = string
    threshold        = number

    action_group_key = string
    tags             = map(string)
  }))

  validation {
    condition = alltrue([
      for alert in var.monitor_alert :
      contains(
        [
          "application_gateway",
          "storage_account",
          "sql_database"
        ],
        alert.target_resource_type
      )
    ])

    error_message = "target_resource_type must be application_gateway, storage_account, or sql_database."
  }

  validation {
    condition = alltrue([
      for alert in var.monitor_alert :
      alert.severity >= 0 && alert.severity <= 4
    ])

    error_message = "Alert severity must be between 0 and 4."
  }

  validation {
    condition = alltrue([
      for alert in var.monitor_alert :
      contains(
        [
          "Average",
          "Minimum",
          "Maximum",
          "Total",
          "Count"
        ],
        alert.aggregation
      )
    ])

    error_message = "Aggregation must be Average, Minimum, Maximum, Total, or Count."
  }

  validation {
    condition = alltrue([
      for alert in var.monitor_alert :
      contains(
        [
          "Equals",
          "NotEquals",
          "GreaterThan",
          "GreaterThanOrEqual",
          "LessThan",
          "LessThanOrEqual"
        ],
        alert.operator
      )
    ])

    error_message = "The metric-alert operator is invalid."
  }
}

# ============================================================
# Azure User-Assigned Managed Identities
# ============================================================

variable "managed_identity" {
  description = "Configuration for Azure User-Assigned Managed Identities"

  type = map(object({
    name               = string
    resource_group_key = string
    tags               = map(string)
  }))
}

# ============================================================
# Azure RBAC Role Assignments
# ============================================================

variable "role_assignment" {
  description = "Configuration for Azure RBAC Role Assignments"

  type = map(object({
    managed_identity_key             = string
    target_resource_type             = string
    target_resource_key              = string
    role_definition_name             = string
    principal_type                   = string
    skip_service_principal_aad_check = bool
    description                      = string
  }))

  validation {
    condition = alltrue([
      for assignment in var.role_assignment :
      contains(
        [
          "key_vault",
          "storage_account"
        ],
        assignment.target_resource_type
      )
    ])

    error_message = "target_resource_type must be key_vault or storage_account."
  }

  validation {
    condition = alltrue([
      for assignment in var.role_assignment :
      contains(
        [
          "Key Vault Secrets User",
          "Storage Blob Data Contributor"
        ],
        assignment.role_definition_name
      )
    ])

    error_message = "Only approved least-privilege Key Vault and Storage roles can be assigned."
  }

  validation {
    condition = alltrue([
      for assignment in var.role_assignment :
      assignment.principal_type == "ServicePrincipal"
    ])

    error_message = "Managed identity role assignments must use the ServicePrincipal principal type."
  }
}

# ============================================================
# Azure Policy Assignments
# ============================================================

variable "azure_policy" {
  description = "Configuration for Azure resource-group policy assignments"

  type = map(object({
    name                   = string
    display_name           = string
    description            = string
    resource_group_key     = string
    policy_definition_key  = string
    enforce                = bool
    parameters             = map(any)
    metadata               = map(string)
    non_compliance_message = string
  }))

  validation {
    condition = alltrue([
      for assignment in var.azure_policy :
      contains(
        ["hub", "prod", "dev"],
        assignment.resource_group_key
      )
    ])

    error_message = "resource_group_key must be hub, prod, or dev."
  }

  validation {
    condition = alltrue([
      for assignment in var.azure_policy :
      assignment.policy_definition_key == "require_tag_value"
    ])

    error_message = "The current policy baseline supports the require_tag_value policy key."
  }

  validation {
    condition = alltrue([
      for assignment in var.azure_policy :
      length(assignment.name) <= 64
    ])

    error_message = "Azure Policy assignment names must not exceed 64 characters."
  }
}