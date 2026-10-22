output "resource_group" {

  value = {
    for key, resource_group in azurerm_resource_group.resource_group :
    key => {
      id       = resource_group.id
      name     = resource_group.name
      location = resource_group.location
    }
  }
}