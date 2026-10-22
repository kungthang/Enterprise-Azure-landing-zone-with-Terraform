
output "vnet_peering" {
  description = "Details of the created virtual network peerings"

  value = {
    for key, vnet_peering in azurerm_virtual_network_peering.vnet_peering :
    key => {
      id   = vnet_peering.id
      name = vnet_peering.name
    }
  }
}
