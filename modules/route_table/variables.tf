variable "route_table" {
  description = "Configuration for Azure route tables"

  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    bgp_route_propagation_enabled = bool
    route_name                    = string
    address_prefix                = string
    next_hop_type                 = string
  }))
}


variable "route_table_association" {
  description = "Configuration for route-table-to-subnet associations"

  type = map(object({
    subnet_key      = string
    route_table_key = string
  }))
}


variable "subnet_id" {
  description = "Map of subnet IDs"
  type        = map(string)
}


variable "firewall_private_ip" {
  description = "Private IP address of Azure Firewall"
  type        = string
}
