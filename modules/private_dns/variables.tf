# ============================================================
# Azure Private DNS Zone Variables
# ============================================================

variable "private_dns_zone" {
  description = "Configuration for Azure Private DNS Zones"

  type = map(object({
    name                = string
    resource_group_name = string
    tags                = map(string)
  }))
}


# ============================================================
# Private DNS Zone VNet Link Variables
# ============================================================

variable "private_dns_zone_vnet_link" {
  description = "Configuration for Private DNS Zone Virtual Network Links"

  type = map(object({
    name                 = string
    private_dns_zone_key = string
    virtual_network_id   = string
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