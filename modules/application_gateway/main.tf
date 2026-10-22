# ============================================================
# Application Gateway Public IP
# ============================================================

resource "azurerm_public_ip" "public_ip" {
  for_each = var.public_ip

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
  zones               = each.value.zones
}


# ============================================================
# Web Application Firewall Policy
# ============================================================

resource "azurerm_web_application_firewall_policy" "waf_policy" {
  for_each = var.waf_policy

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  policy_settings {
    enabled                     = each.value.enabled
    mode                        = each.value.mode
    request_body_check          = each.value.request_body_check
    file_upload_limit_in_mb     = each.value.file_upload_limit_in_mb
    max_request_body_size_in_kb = each.value.max_request_body_size_in_kb
  }

  managed_rules {
    managed_rule_set {
      type    = each.value.managed_rule_set_type
      version = each.value.managed_rule_set_version
    }
  }
}


# ============================================================
# Application Gateway WAF v2
# ============================================================

resource "azurerm_application_gateway" "application_gateway" {
  for_each = var.application_gateway

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  zones               = each.value.zones

  firewall_policy_id = azurerm_web_application_firewall_policy.waf_policy[
    each.value.waf_policy_key
  ].id

  force_firewall_policy_association = true

  # ----------------------------------------------------------
  # SKU
  # ----------------------------------------------------------

  sku {
    name = each.value.sku_name
    tier = each.value.sku_tier
  }

  # ----------------------------------------------------------
  # Autoscaling
  # ----------------------------------------------------------

  autoscale_configuration {
    min_capacity = each.value.autoscale_min_capacity
    max_capacity = each.value.autoscale_max_capacity
  }

  # ----------------------------------------------------------
  # Gateway Subnet
  # ----------------------------------------------------------

  gateway_ip_configuration {
    name      = each.value.gateway_ip_configuration_name
    subnet_id = var.application_gateway_subnet_id
  }

  # ----------------------------------------------------------
  # Public Frontend
  # ----------------------------------------------------------

  frontend_ip_configuration {
    name = each.value.frontend_ip_configuration_name

    public_ip_address_id = azurerm_public_ip.public_ip[
      each.value.public_ip_key
    ].id
  }

  frontend_port {
    name = each.value.frontend_port_name
    port = each.value.frontend_port
  }

  # ----------------------------------------------------------
  # Backend Pool
  #
  # Empty until the Production Web Tier is deployed.
  # ----------------------------------------------------------

  backend_address_pool {
    name = each.value.backend_address_pool_name
  }

  # ----------------------------------------------------------
  # Backend Settings
  # ----------------------------------------------------------

  backend_http_settings {
    name                  = each.value.backend_http_settings_name
    protocol              = each.value.backend_protocol
    port                  = each.value.backend_port
    cookie_based_affinity = each.value.cookie_based_affinity
    request_timeout       = each.value.request_timeout
  }

  # ----------------------------------------------------------
  # HTTP Listener
  #
  # Temporary HTTP baseline.
  # Change to HTTPS after Key Vault certificate deployment.
  # ----------------------------------------------------------

  http_listener {
    name = each.value.http_listener_name

    frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
    frontend_port_name             = each.value.frontend_port_name
    protocol                       = each.value.listener_protocol
  }

  # ----------------------------------------------------------
  # Routing Rule
  # ----------------------------------------------------------

  request_routing_rule {
    name      = each.value.request_routing_rule_name
    rule_type = each.value.routing_rule_type
    priority  = each.value.routing_rule_priority

    http_listener_name         = each.value.http_listener_name
    backend_address_pool_name  = each.value.backend_address_pool_name
    backend_http_settings_name = each.value.backend_http_settings_name
  }
}