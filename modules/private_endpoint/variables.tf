# ============================================================
# Azure Private Endpoint Variables
# ============================================================

variable "private_endpoint" {
  description = "Configuration for Azure Private Endpoints"

  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    subnet_id                       = string
    private_service_connection_name = string
    private_connection_resource_id  = string
    subresource_name                = string
    is_manual_connection            = bool
    private_dns_zone_group_name     = string
    private_dns_zone_id             = string
    tags                            = map(string)
  }))

  validation {
    condition = alltrue([
      for private_endpoint in var.private_endpoint :
      contains(
        ["vault", "blob", "sqlServer"],
        private_endpoint.subresource_name
      )
    ])

    error_message = "subresource_name must be vault, blob, or sqlServer."
  }

  validation {
    condition = alltrue([
      for private_endpoint in var.private_endpoint :
      private_endpoint.is_manual_connection == false
    ])

    error_message = "Private Endpoint connections must use automatic approval."
  }
}