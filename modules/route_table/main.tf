# ============================================================
# Route Tables
# ============================================================

resource "azurerm_route_table" "route_table" {
  for_each = var.route_table

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  bgp_route_propagation_enabled = each.value.bgp_route_propagation_enabled


  route {
    name           = each.value.route_name
    address_prefix = each.value.address_prefix
    next_hop_type  = each.value.next_hop_type

    next_hop_in_ip_address = (
      each.value.next_hop_type == "VirtualAppliance"
      ? var.firewall_private_ip
      : null
    )
  }
}


# ============================================================
# Route Table to Subnet Associations
# ============================================================

resource "azurerm_subnet_route_table_association" "route_table_association" {
  for_each = var.route_table_association

  subnet_id = var.subnet_id[
    each.value.subnet_key
  ]

  route_table_id = azurerm_route_table.route_table[
    each.value.route_table_key
  ].id
}