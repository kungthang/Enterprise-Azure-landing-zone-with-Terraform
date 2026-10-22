# ============================================================
# VPN Gateway Public IP
# ============================================================

resource "azurerm_public_ip" "public_ip" {
  for_each = var.public_ip

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}


# ============================================================
# VPN Gateway
# ============================================================

resource "azurerm_virtual_network_gateway" "vpn_gateway" {
  for_each = var.vpn_gateway

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  type          = each.value.type
  vpn_type      = each.value.vpn_type
  sku           = each.value.sku
  active_active = each.value.active_active
  bgp_enabled   = each.value.bgp_enabled

  ip_configuration {
    name                          = each.value.ip_configuration_name
    public_ip_address_id          = azurerm_public_ip.public_ip[each.value.public_ip_key].id
    private_ip_address_allocation = each.value.private_ip_address_allocation
    subnet_id                     = var.gateway_subnet_id
  }
}