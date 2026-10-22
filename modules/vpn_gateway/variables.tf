# ============================================================
# VPN Gateway Public IP
# ============================================================

variable "public_ip" {
  description = "Configuration for VPN Gateway public IP addresses"

  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method   = string
    sku                 = string
  }))
}


# ============================================================
# VPN Gateway
# ============================================================

variable "vpn_gateway" {
  description = "Configuration for Azure VPN Gateway"

  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
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
# Gateway Subnet
# ============================================================

variable "gateway_subnet_id" {
  description = "Resource ID of GatewaySubnet"
  type        = string
}