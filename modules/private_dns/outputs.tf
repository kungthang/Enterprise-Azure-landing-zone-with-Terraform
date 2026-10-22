# ============================================================
# Azure Private DNS Zone Outputs
# ============================================================

output "private_dns_zone" {
  description = "Details of the created Azure Private DNS Zones"

  value = {
    for key, private_dns_zone in azurerm_private_dns_zone.private_dns_zone :
    key => {
      id   = private_dns_zone.id
      name = private_dns_zone.name
    }
  }
}


# ============================================================
# Private DNS Zone VNet Link Outputs
# ============================================================

output "private_dns_zone_vnet_link" {
  description = "Details of the created Private DNS Zone VNet Links"

  value = {
    for key, virtual_network_link in azurerm_private_dns_zone_virtual_network_link.virtual_network_link :
    key => {
      id   = virtual_network_link.id
      name = virtual_network_link.name
    }
  }
}