# ============================================================
# Azure Private DNS Zones
# ============================================================

resource "azurerm_private_dns_zone" "private_dns_zone" {
  for_each = var.private_dns_zone

  name                = each.value.name
  resource_group_name = each.value.resource_group_name

  tags = each.value.tags
}


# ============================================================
# Private DNS Zone Virtual Network Links
# ============================================================

resource "azurerm_private_dns_zone_virtual_network_link" "virtual_network_link" {
  for_each = var.private_dns_zone_vnet_link

  name = each.value.name

  private_dns_zone_id = azurerm_private_dns_zone.private_dns_zone[
    each.value.private_dns_zone_key
  ].id

  virtual_network_id = each.value.virtual_network_id

  registration_enabled = each.value.registration_enabled

  tags = each.value.tags
}