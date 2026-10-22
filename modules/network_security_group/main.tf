# ============================================================
# Network Security Groups
# ============================================================

resource "azurerm_network_security_group" "network_security_group" {
  for_each = var.network_security_group

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}


# ============================================================
# Network Security Rules
# ============================================================

resource "azurerm_network_security_rule" "network_security_rule" {
  for_each = var.network_security_rule

  name                       = each.value.name
  priority                   = each.value.priority
  direction                  = each.value.direction
  access                     = each.value.access
  protocol                   = each.value.protocol
  source_port_range          = each.value.source_port_range
  destination_port_range     = each.value.destination_port_range
  source_address_prefix      = each.value.source_address_prefix
  destination_address_prefix = each.value.destination_address_prefix
  resource_group_name        = each.value.resource_group_name

  network_security_group_name = azurerm_network_security_group.network_security_group[
    each.value.network_security_group_key
  ].name
}


# ============================================================
# NSG-to-Subnet Associations
# ============================================================

resource "azurerm_subnet_network_security_group_association" "subnet_association" {
  for_each = var.network_security_group

  subnet_id = var.subnet_id[each.key]

  network_security_group_id = azurerm_network_security_group.network_security_group[
    each.key
  ].id
}