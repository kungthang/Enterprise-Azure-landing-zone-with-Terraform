output "virtual_network" {

  value = {
    for key, virtual_network in azurerm_virtual_network.virtual_network :
    key => {
      id                  = virtual_network.id
      name                = virtual_network.name
      resource_group_name = virtual_network.resource_group_name
    }
  }
}