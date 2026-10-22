# ============================================================
# Resource Groups
# ============================================================

module "resource_group" {
  source = "./modules/resource_group"

  resource_group = var.resource_group
}


# ============================================================
# Virtual Networks
# ============================================================

module "virtual_network" {
  source = "./modules/virtual_network"

  virtual_network = var.virtual_network

  depends_on = [
    module.resource_group
  ]
}


# ============================================================
# Subnets
# ============================================================

module "subnet" {
  source = "./modules/subnet"

  subnet = var.subnet

  depends_on = [
    module.virtual_network
  ]
}


# ============================================================
# Virtual Network Peerings
# ============================================================

module "vnet_peering" {
  source = "./modules/vnet_peering"

  vnet_peering = {
    for key, vnet_peering in var.vnet_peering :
    key => {
      name                 = vnet_peering.name
      resource_group_name  = vnet_peering.resource_group_name
      virtual_network_name = vnet_peering.virtual_network_name

      remote_virtual_network_id = module.virtual_network.virtual_network[
        vnet_peering.remote_vnet_key
      ].id
    }
  }

  depends_on = [
    module.virtual_network
  ]
}


# ============================================================
# Network Security Groups
# ============================================================

module "network_security_group" {
  source = "./modules/network_security_group"

  network_security_group = {
    for key, nsg in var.network_security_group :
    key => {
      name = nsg.name

      location = module.resource_group.resource_group[
        nsg.resource_group_key
      ].location

      resource_group_name = module.resource_group.resource_group[
        nsg.resource_group_key
      ].name
    }
  }

  network_security_rule = {
    for key, rule in var.network_security_rule :
    key => {
      name                       = rule.name
      priority                   = rule.priority
      direction                  = rule.direction
      access                     = rule.access
      protocol                   = rule.protocol
      source_port_range          = rule.source_port_range
      destination_port_range     = rule.destination_port_range
      source_address_prefix      = rule.source_address_prefix
      destination_address_prefix = rule.destination_address_prefix

      resource_group_name = module.resource_group.resource_group[
        rule.resource_group_key
      ].name

      network_security_group_key = rule.network_security_group_key
    }
  }

  subnet_id = {
    for key, subnet in module.subnet.subnet :
    key => subnet.id
  }

  depends_on = [
    module.resource_group,
    module.subnet
  ]
}


# ============================================================
# Azure Firewall
# ============================================================

module "azure_firewall" {
  source = "./modules/azure_firewall"

  public_ip = {
    for key, public_ip in var.public_ip :
    key => {
      name = public_ip.name

      location = module.resource_group.resource_group[
        public_ip.resource_group_key
      ].location

      resource_group_name = module.resource_group.resource_group[
        public_ip.resource_group_key
      ].name

      allocation_method = public_ip.allocation_method
      sku               = public_ip.sku
    }
  }

  azure_firewall = {
    for key, firewall in var.azure_firewall :
    key => {
      name = firewall.name

      location = module.resource_group.resource_group[
        firewall.resource_group_key
      ].location

      resource_group_name = module.resource_group.resource_group[
        firewall.resource_group_key
      ].name

      sku_name              = firewall.sku_name
      sku_tier              = firewall.sku_tier
      ip_configuration_name = firewall.ip_configuration_name
      public_ip_key         = firewall.public_ip_key
    }
  }

  firewall_subnet_id = module.subnet.firewall_subnet_id

  depends_on = [
    module.resource_group,
    module.subnet
  ]
}

# ============================================================
# Route Tables
# ============================================================

module "route_table" {
  source = "./modules/route_table"

  route_table = {
    for key, route_table in var.route_table :
    key => {
      name = route_table.name

      location = module.resource_group.resource_group[
        route_table.resource_group_key
      ].location

      resource_group_name = module.resource_group.resource_group[
        route_table.resource_group_key
      ].name

      bgp_route_propagation_enabled = route_table.bgp_route_propagation_enabled
      route_name                    = route_table.route_name
      address_prefix                = route_table.address_prefix
      next_hop_type                 = route_table.next_hop_type
    }
  }

  route_table_association = var.route_table_association

  subnet_id = {
    for key, subnet in module.subnet.subnet :
    key => subnet.id
  }

  firewall_private_ip = module.azure_firewall.azure_firewall[
    "firewall"
  ].private_ip

  depends_on = [
    module.azure_firewall,
    module.subnet
  ]
}

# ============================================================
# Azure Bastion
# ============================================================

module "azure_bastion" {
  source = "./modules/azure_bastion"

  public_ip = {
    for key, public_ip in var.bastion_public_ip :
    key => {
      name = public_ip.name

      location = module.resource_group.resource_group[
        public_ip.resource_group_key
      ].location

      resource_group_name = module.resource_group.resource_group[
        public_ip.resource_group_key
      ].name

      allocation_method = public_ip.allocation_method
      sku               = public_ip.sku
      tags              = public_ip.tags
    }
  }

  azure_bastion = {
    for key, bastion in var.azure_bastion :
    key => {
      name = bastion.name

      location = module.resource_group.resource_group[
        bastion.resource_group_key
      ].location

      resource_group_name = module.resource_group.resource_group[
        bastion.resource_group_key
      ].name

      sku                   = bastion.sku
      copy_paste_enabled    = bastion.copy_paste_enabled
      file_copy_enabled     = bastion.file_copy_enabled
      ip_configuration_name = bastion.ip_configuration_name
      public_ip_key         = bastion.public_ip_key
      tags                  = bastion.tags
    }
  }

  bastion_subnet_id = module.subnet.bastion_subnet_id

  depends_on = [
    module.resource_group,
    module.subnet
  ]
}

# ============================================================
# VPN Gateway
# ============================================================

module "vpn_gateway" {
  source = "./modules/vpn_gateway"

  public_ip = {
    for key, public_ip in var.vpn_gateway_public_ip :
    key => {
      name = public_ip.name

      location = module.resource_group.resource_group[
        public_ip.resource_group_key
      ].location

      resource_group_name = module.resource_group.resource_group[
        public_ip.resource_group_key
      ].name

      allocation_method = public_ip.allocation_method
      sku               = public_ip.sku
    }
  }

  vpn_gateway = {
    for key, vpn_gateway in var.vpn_gateway :
    key => {
      name = vpn_gateway.name

      location = module.resource_group.resource_group[
        vpn_gateway.resource_group_key
      ].location

      resource_group_name = module.resource_group.resource_group[
        vpn_gateway.resource_group_key
      ].name

      type                          = vpn_gateway.type
      vpn_type                      = vpn_gateway.vpn_type
      sku                           = vpn_gateway.sku
      active_active                 = vpn_gateway.active_active
      bgp_enabled                   = vpn_gateway.bgp_enabled
      ip_configuration_name         = vpn_gateway.ip_configuration_name
      private_ip_address_allocation = vpn_gateway.private_ip_address_allocation
      public_ip_key                 = vpn_gateway.public_ip_key
    }
  }

  gateway_subnet_id = module.subnet.gateway_subnet_id

  depends_on = [
    module.resource_group,
    module.subnet
  ]
}

# ============================================================
# Application Gateway WAF v2
# ============================================================

module "application_gateway" {
  source = "./modules/application_gateway"

  # ----------------------------------------------------------
  # Application Gateway Public IP
  # ----------------------------------------------------------

  public_ip = {
    for key, public_ip in var.application_gateway_public_ip :
    key => {
      name = public_ip.name

      location = module.resource_group.resource_group[
        public_ip.resource_group_key
      ].location

      resource_group_name = module.resource_group.resource_group[
        public_ip.resource_group_key
      ].name

      allocation_method = public_ip.allocation_method
      sku               = public_ip.sku
      zones             = public_ip.zones
    }
  }

  # ----------------------------------------------------------
  # Application Gateway WAF Policy
  # ----------------------------------------------------------

  waf_policy = {
    for key, waf_policy in var.application_gateway_waf_policy :
    key => {
      name = waf_policy.name

      location = module.resource_group.resource_group[
        waf_policy.resource_group_key
      ].location

      resource_group_name = module.resource_group.resource_group[
        waf_policy.resource_group_key
      ].name

      enabled                     = waf_policy.enabled
      mode                        = waf_policy.mode
      request_body_check          = waf_policy.request_body_check
      file_upload_limit_in_mb     = waf_policy.file_upload_limit_in_mb
      max_request_body_size_in_kb = waf_policy.max_request_body_size_in_kb
      managed_rule_set_type       = waf_policy.managed_rule_set_type
      managed_rule_set_version    = waf_policy.managed_rule_set_version
    }
  }

  # ----------------------------------------------------------
  # Application Gateway
  # ----------------------------------------------------------

  application_gateway = {
    for key, application_gateway in var.application_gateway :
    key => {
      name = application_gateway.name

      location = module.resource_group.resource_group[
        application_gateway.resource_group_key
      ].location

      resource_group_name = module.resource_group.resource_group[
        application_gateway.resource_group_key
      ].name

      zones                          = application_gateway.zones
      sku_name                       = application_gateway.sku_name
      sku_tier                       = application_gateway.sku_tier
      autoscale_min_capacity         = application_gateway.autoscale_min_capacity
      autoscale_max_capacity         = application_gateway.autoscale_max_capacity
      gateway_ip_configuration_name  = application_gateway.gateway_ip_configuration_name
      frontend_ip_configuration_name = application_gateway.frontend_ip_configuration_name
      frontend_port_name             = application_gateway.frontend_port_name
      frontend_port                  = application_gateway.frontend_port
      backend_address_pool_name      = application_gateway.backend_address_pool_name
      backend_http_settings_name     = application_gateway.backend_http_settings_name
      backend_protocol               = application_gateway.backend_protocol
      backend_port                   = application_gateway.backend_port
      cookie_based_affinity          = application_gateway.cookie_based_affinity
      request_timeout                = application_gateway.request_timeout
      http_listener_name             = application_gateway.http_listener_name
      listener_protocol              = application_gateway.listener_protocol
      request_routing_rule_name      = application_gateway.request_routing_rule_name
      routing_rule_type              = application_gateway.routing_rule_type
      routing_rule_priority          = application_gateway.routing_rule_priority
      public_ip_key                  = application_gateway.public_ip_key
      waf_policy_key                 = application_gateway.waf_policy_key
    }
  }

  # ApplicationGatewaySubnet ID from the subnet child-module output
  application_gateway_subnet_id = module.subnet.application_gateway_subnet_id

  depends_on = [
    module.resource_group,
    module.subnet
  ]
}

# ============================================================
# Azure Key Vault
# ============================================================

module "key_vault" {
  source = "./modules/key_vault"

  key_vault = {
    for key, key_vault in var.key_vault :
    key => {
      name = key_vault.name

      location = module.resource_group.resource_group[
        key_vault.resource_group_key
      ].location

      resource_group_name = module.resource_group.resource_group[
        key_vault.resource_group_key
      ].name

      sku_name                      = key_vault.sku_name
      soft_delete_retention_days    = key_vault.soft_delete_retention_days
      purge_protection_enabled      = key_vault.purge_protection_enabled
      rbac_authorization_enabled    = key_vault.rbac_authorization_enabled
      public_network_access_enabled = key_vault.public_network_access_enabled
      tags                          = key_vault.tags
    }
  }

  depends_on = [
    module.resource_group
  ]
}

# ============================================================
# Azure Storage Accounts
# ============================================================

module "storage_account" {
  source = "./modules/storage_account"

  storage_account = {
    for key, storage_account in var.storage_account :
    key => {
      name = storage_account.name

      location = module.resource_group.resource_group[
        storage_account.resource_group_key
      ].location

      resource_group_name = module.resource_group.resource_group[
        storage_account.resource_group_key
      ].name

      account_kind                    = storage_account.account_kind
      account_tier                    = storage_account.account_tier
      account_replication_type        = storage_account.account_replication_type
      access_tier                     = storage_account.access_tier
      https_traffic_only_enabled      = storage_account.https_traffic_only_enabled
      min_tls_version                 = storage_account.min_tls_version
      public_network_access           = storage_account.public_network_access
      allow_nested_items_to_be_public = storage_account.allow_nested_items_to_be_public
      shared_access_key_enabled       = storage_account.shared_access_key_enabled
      default_to_oauth_authentication = storage_account.default_to_oauth_authentication
      tags                            = storage_account.tags
    }
  }

  depends_on = [
    module.resource_group
  ]
}
# ============================================================
# Azure SQL Logical Servers
# ============================================================

module "sql_server" {
  source = "./modules/sql_server"

  sql_server = {
    for key, sql_server in var.sql_server :
    key => {
      name = sql_server.name

      location = module.resource_group.resource_group[
        sql_server.resource_group_key
      ].location

      resource_group_name = module.resource_group.resource_group[
        sql_server.resource_group_key
      ].name

      version             = sql_server.version
      administrator_login = sql_server.administrator_login

      minimum_tls_version           = sql_server.minimum_tls_version
      public_network_access_enabled = sql_server.public_network_access_enabled

      azuread_administrator_login_username = sql_server.azuread_administrator_login_username
      azuread_administrator_object_id      = sql_server.azuread_administrator_object_id
      azuread_administrator_tenant_id      = sql_server.azuread_administrator_tenant_id
      azuread_authentication_only          = sql_server.azuread_authentication_only

      tags = sql_server.tags
    }
  }

  # Pass passwords separately.
  # Do not combine passwords into the sql_server map.
  sql_administrator_passwords = var.sql_administrator_passwords

  depends_on = [
    module.resource_group
  ]
}

# ============================================================
# Azure SQL Databases
# ============================================================

module "sql_database" {
  source = "./modules/sql_database"

  sql_database = {
    for key, sql_database in var.sql_database :
    key => {
      name = sql_database.name

      server_id = module.sql_server.sql_server[
        sql_database.sql_server_key
      ].id

      collation                           = sql_database.collation
      sku_name                            = sql_database.sku_name
      max_size_gb                         = sql_database.max_size_gb
      zone_redundant                      = sql_database.zone_redundant
      read_scale                          = sql_database.read_scale
      storage_account_type                = sql_database.storage_account_type
      transparent_data_encryption_enabled = sql_database.transparent_data_encryption_enabled
      tags                                = sql_database.tags
    }
  }

  depends_on = [
    module.sql_server
  ]
}

# ============================================================
# Azure Private DNS
# ============================================================

module "private_dns" {
  source = "./modules/private_dns"

  # ----------------------------------------------------------
  # Private DNS Zones
  # ----------------------------------------------------------

  private_dns_zone = {
    for key, private_dns_zone in var.private_dns_zone :
    key => {
      name = private_dns_zone.name

      resource_group_name = module.resource_group.resource_group[
        private_dns_zone.resource_group_key
      ].name

      tags = private_dns_zone.tags
    }
  }

  # ----------------------------------------------------------
  # Private DNS Zone VNet Links
  # ----------------------------------------------------------

  private_dns_zone_vnet_link = {
    for key, vnet_link in var.private_dns_zone_vnet_link :
    key => {
      name                 = vnet_link.name
      private_dns_zone_key = vnet_link.private_dns_zone_key

      virtual_network_id = module.virtual_network.virtual_network[
        vnet_link.virtual_network_key
      ].id

      registration_enabled = vnet_link.registration_enabled
      tags                 = vnet_link.tags
    }
  }

  depends_on = [
    module.resource_group,
    module.virtual_network
  ]
}

# ============================================================
# Azure Private Endpoints
# ============================================================

module "private_endpoint" {
  source = "./modules/private_endpoint"

  private_endpoint = {
    for key, private_endpoint in var.private_endpoint :
    key => {
      name = private_endpoint.name

      # ------------------------------------------------------
      # Resource Group
      # ------------------------------------------------------

      location = module.resource_group.resource_group[
        private_endpoint.resource_group_key
      ].location

      resource_group_name = module.resource_group.resource_group[
        private_endpoint.resource_group_key
      ].name

      # ------------------------------------------------------
      # Private Endpoint Subnet
      # ------------------------------------------------------

      subnet_id = module.subnet.subnet[
        private_endpoint.subnet_key
      ].id

      # ------------------------------------------------------
      # Target PaaS Resource
      # ------------------------------------------------------

      private_connection_resource_id = (
        private_endpoint.target_resource_type == "key_vault"
        ? module.key_vault.key_vault[
          private_endpoint.target_resource_key
        ].id
        : private_endpoint.target_resource_type == "storage_account"
        ? module.storage_account.storage_account[
          private_endpoint.target_resource_key
        ].id
        : module.sql_server.sql_server[
          private_endpoint.target_resource_key
        ].id
      )

      private_service_connection_name = private_endpoint.private_service_connection_name
      subresource_name                = private_endpoint.subresource_name
      is_manual_connection            = private_endpoint.is_manual_connection

      # ------------------------------------------------------
      # Private DNS Zone
      # ------------------------------------------------------

      private_dns_zone_group_name = private_endpoint.private_dns_zone_group_name

      private_dns_zone_id = module.private_dns.private_dns_zone[
        private_endpoint.private_dns_zone_key
      ].id

      tags = private_endpoint.tags
    }
  }

  depends_on = [
    module.subnet,
    module.key_vault,
    module.storage_account,
    module.sql_server,
    module.private_dns
  ]
}

# ============================================================
# Azure Log Analytics Workspace
# ============================================================

module "log_analytics" {
  source = "./modules/log_analytics"

  log_analytics = {
    for key, workspace in var.log_analytics :
    key => {
      name = workspace.name

      location = module.resource_group.resource_group[
        workspace.resource_group_key
      ].location

      resource_group_name = module.resource_group.resource_group[
        workspace.resource_group_key
      ].name

      sku               = workspace.sku
      retention_in_days = workspace.retention_in_days
      daily_quota_gb    = workspace.daily_quota_gb

      local_authentication_enabled    = workspace.local_authentication_enabled
      allow_resource_only_permissions = workspace.allow_resource_only_permissions

      internet_ingestion_access_type = workspace.internet_ingestion_access_type
      internet_query_access_type     = workspace.internet_query_access_type

      tags = workspace.tags
    }
  }

  depends_on = [
    module.resource_group
  ]
}

# ============================================================
# Azure Monitor Diagnostic Settings
# ============================================================

module "diagnostic_settings" {
  source = "./modules/diagnostic_settings"

  diagnostic_setting = {
    for key, setting in var.diagnostic_setting :
    key => {
      name = setting.name

      # ------------------------------------------------------
      # Select the target resource ID based on resource type
      # ------------------------------------------------------

      target_resource_id = (
        setting.target_resource_type == "azure_firewall"
        ? module.azure_firewall.azure_firewall[
          setting.target_resource_key
        ].id

        : setting.target_resource_type == "application_gateway"
        ? module.application_gateway.application_gateway[
          setting.target_resource_key
        ].id

        : setting.target_resource_type == "azure_bastion"
        ? module.azure_bastion.azure_bastion[
          setting.target_resource_key
        ].id

        : setting.target_resource_type == "vpn_gateway"
        ? module.vpn_gateway.vpn_gateway[
          setting.target_resource_key
        ].id

        : setting.target_resource_type == "key_vault"
        ? module.key_vault.key_vault[
          setting.target_resource_key
        ].id

        : setting.target_resource_type == "storage_account"
        ? module.storage_account.storage_account[
          setting.target_resource_key
        ].id

        : setting.target_resource_type == "sql_server"
        ? module.sql_server.sql_server[
          setting.target_resource_key
        ].id

        : module.sql_database.sql_database[
          setting.target_resource_key
        ].id
      )

      # ------------------------------------------------------
      # Central Log Analytics Workspace
      # ------------------------------------------------------

      log_analytics_workspace_id = module.log_analytics.log_analytics[
        "hub"
      ].id

      log_analytics_destination_type = setting.log_analytics_destination_type

      # ------------------------------------------------------
      # Logs and metrics
      # ------------------------------------------------------

      log_category_groups = setting.log_category_groups
      log_categories      = setting.log_categories
      metric_categories   = setting.metric_categories
    }
  }

  depends_on = [
    module.log_analytics,
    module.azure_firewall,
    module.application_gateway,
    module.azure_bastion,
    module.vpn_gateway,
    module.key_vault,
    module.storage_account,
    module.sql_server,
    module.sql_database
  ]
}

# ============================================================
# Azure Monitor Action Groups
# ============================================================

module "action_group" {
  source = "./modules/action_group"

  action_group = {
    for key, action_group in var.action_group :
    key => {
      name = action_group.name

      resource_group_name = module.resource_group.resource_group[
        action_group.resource_group_key
      ].name

      short_name      = action_group.short_name
      email_receivers = action_group.email_receivers
      tags            = action_group.tags
    }
  }

  depends_on = [
    module.resource_group
  ]
}

# ============================================================
# Azure Monitor Metric Alerts
# ============================================================

module "monitor_alert" {
  source = "./modules/monitor_alert"

  monitor_alert = {
    for key, alert in var.monitor_alert :
    key => {
      name = alert.name

      resource_group_name = module.resource_group.resource_group[
        alert.resource_group_key
      ].name

      # ------------------------------------------------------
      # Select the monitored Azure resource
      # ------------------------------------------------------

      target_resource_id = (
        alert.target_resource_type == "application_gateway"
        ? module.application_gateway.application_gateway[
          alert.target_resource_key
        ].id

        : alert.target_resource_type == "storage_account"
        ? module.storage_account.storage_account[
          alert.target_resource_key
        ].id

        : module.sql_database.sql_database[
          alert.target_resource_key
        ].id
      )

      description = alert.description
      severity    = alert.severity
      enabled     = alert.enabled

      frequency     = alert.frequency
      window_size   = alert.window_size
      auto_mitigate = alert.auto_mitigate

      metric_namespace = alert.metric_namespace
      metric_name      = alert.metric_name
      aggregation      = alert.aggregation
      operator         = alert.operator
      threshold        = alert.threshold

      # ------------------------------------------------------
      # Existing shared Action Group
      # ------------------------------------------------------

      action_group_id = module.action_group.action_group[
        alert.action_group_key
      ].id

      tags = alert.tags
    }
  }

  depends_on = [
    module.action_group,
    module.application_gateway,
    module.storage_account,
    module.sql_database
  ]
}

# ============================================================
# Azure User-Assigned Managed Identities
# ============================================================

module "managed_identity" {
  source = "./modules/managed_identity"

  managed_identity = {
    for key, identity in var.managed_identity :
    key => {
      name = identity.name

      location = module.resource_group.resource_group[
        identity.resource_group_key
      ].location

      resource_group_name = module.resource_group.resource_group[
        identity.resource_group_key
      ].name

      tags = identity.tags
    }
  }

  depends_on = [
    module.resource_group
  ]
}


# ============================================================
# Azure RBAC Role Assignments
# ============================================================

module "role_assignment" {
  source = "./modules/role_assignment"

  role_assignment = {
    for key, assignment in var.role_assignment :
    key => {
      # ------------------------------------------------------
      # Managed Identity principal
      # ------------------------------------------------------

      principal_id = module.managed_identity.managed_identity[
        assignment.managed_identity_key
      ].principal_id

      principal_type = assignment.principal_type

      # ------------------------------------------------------
      # Target Azure resource scope
      # ------------------------------------------------------

      scope = (
        assignment.target_resource_type == "key_vault"
        ? module.key_vault.key_vault[
          assignment.target_resource_key
        ].id

        : module.storage_account.storage_account[
          assignment.target_resource_key
        ].id
      )

      # ------------------------------------------------------
      # Role configuration
      # ------------------------------------------------------

      role_definition_name             = assignment.role_definition_name
      skip_service_principal_aad_check = assignment.skip_service_principal_aad_check
      description                      = assignment.description
    }
  }

  depends_on = [
    module.managed_identity,
    module.key_vault,
    module.storage_account
  ]
}

# ============================================================
# Azure Policy Assignments
# ============================================================

module "azure_policy" {
  source = "./modules/azure_policy"

  azure_policy = {
    for key, assignment in var.azure_policy :
    key => {
      name         = assignment.name
      display_name = assignment.display_name
      description  = assignment.description

      resource_group_id = module.resource_group.resource_group[
        assignment.resource_group_key
      ].id

      policy_definition_id = (
        assignment.policy_definition_key == "require_tag_value"
        ? data.azurerm_policy_definition.require_tag_value.id
        : null
      )

      enforce                = assignment.enforce
      parameters             = assignment.parameters
      metadata               = assignment.metadata
      non_compliance_message = assignment.non_compliance_message
    }
  }

  depends_on = [
    module.resource_group
  ]
}