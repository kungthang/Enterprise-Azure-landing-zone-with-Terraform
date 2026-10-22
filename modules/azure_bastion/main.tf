# ============================================================
# Azure Bastion Public IP
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
# Azure Bastion Host
# ============================================================

resource "azurerm_bastion_host" "azure_bastion" {
  for_each = var.azure_bastion

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku

  copy_paste_enabled = each.value.copy_paste_enabled
  file_copy_enabled  = each.value.file_copy_enabled

  ip_configuration {
    name                 = each.value.ip_configuration_name
    subnet_id            = var.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.public_ip[each.value.public_ip_key].id
  }

}