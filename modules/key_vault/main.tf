# ============================================================
# Current Azure Client Configuration
# ============================================================

data "azurerm_client_config" "current" {}


# ============================================================
# Azure Key Vault
# ============================================================

resource "azurerm_key_vault" "key_vault" {
  for_each = var.key_vault

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  tenant_id = data.azurerm_client_config.current.tenant_id
  sku_name  = each.value.sku_name

  soft_delete_retention_days = each.value.soft_delete_retention_days
  purge_protection_enabled   = each.value.purge_protection_enabled

  rbac_authorization_enabled    = each.value.rbac_authorization_enabled
  public_network_access_enabled = each.value.public_network_access_enabled

  tags = each.value.tags
}