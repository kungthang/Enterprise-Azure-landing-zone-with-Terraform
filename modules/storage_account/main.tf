resource "azurerm_storage_account" "storage_account" {
  for_each = var.storage_account

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  account_kind             = each.value.account_kind
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
  access_tier              = each.value.access_tier

  https_traffic_only_enabled = each.value.https_traffic_only_enabled
  min_tls_version            = each.value.min_tls_version

  # Replaces public_network_access_enabled
  public_network_access = each.value.public_network_access

  allow_nested_items_to_be_public = each.value.allow_nested_items_to_be_public
  shared_access_key_enabled       = each.value.shared_access_key_enabled
  default_to_oauth_authentication = each.value.default_to_oauth_authentication

  tags = each.value.tags
}