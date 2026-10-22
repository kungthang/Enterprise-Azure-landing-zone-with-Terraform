# ============================================================
# Azure Private Endpoint Outputs
# ============================================================

output "private_endpoint" {
  description = "Details of the created Azure Private Endpoints"

  value = {
    for key, private_endpoint in azurerm_private_endpoint.private_endpoint :
    key => {
      id   = private_endpoint.id
      name = private_endpoint.name

      private_ip_address = private_endpoint.private_service_connection[
        0
      ].private_ip_address

      network_interface_id = private_endpoint.network_interface[
        0
      ].id
    }
  }
}