resource "azurerm_public_ip" "public_ip" {
  for_each = var.public_ip

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}

resource "azurerm_firewall" "azure_firewall" {
  for_each = var.azure_firewall

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku_name            = each.value.sku_name
  sku_tier            = each.value.sku_tier

  ip_configuration {
    name                 = each.value.ip_configuration_name
    subnet_id            = var.firewall_subnet_id
    public_ip_address_id = azurerm_public_ip.public_ip[each.value.public_ip_key].id
  }
}