# ============================================================
# Azure Private Endpoints
# ============================================================

resource "azurerm_private_endpoint" "private_endpoint" {
  for_each = var.private_endpoint

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  subnet_id           = each.value.subnet_id

  # ----------------------------------------------------------
  # Private Service Connection
  # ----------------------------------------------------------

  private_service_connection {
    name = each.value.private_service_connection_name

    private_connection_resource_id = each.value.private_connection_resource_id

    subresource_names = [
      each.value.subresource_name
    ]

    is_manual_connection = each.value.is_manual_connection
  }

  # ----------------------------------------------------------
  # Private DNS Zone Group
  # ----------------------------------------------------------

  private_dns_zone_group {
    name = each.value.private_dns_zone_group_name

    private_dns_zone_ids = [
      each.value.private_dns_zone_id
    ]
  }

  tags = each.value.tags
}