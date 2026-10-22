# ============================================================
# Application Gateway Public IP
# ============================================================

variable "public_ip" {
  description = "Configuration for Application Gateway public IP addresses"

  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method   = string
    sku                 = string
    zones               = list(string)
  }))
}


# ============================================================
# WAF Policy
# ============================================================

variable "waf_policy" {
  description = "Configuration for Application Gateway WAF policies"

  type = map(object({
    name                        = string
    location                    = string
    resource_group_name         = string
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
    location                       = string
    resource_group_name            = string
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
# Application Gateway Subnet
# ============================================================

variable "application_gateway_subnet_id" {
  description = "Resource ID of ApplicationGatewaySubnet"
  type        = string
}