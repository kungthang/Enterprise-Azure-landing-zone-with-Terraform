output "route_table" {
  description = "Details of the created route tables"

  value = {
    for key, route_table in azurerm_route_table.route_table :
    key => {
      id   = route_table.id
      name = route_table.name
    }
  }
}


output "route_table_association" {
  description = "Details of the route-table-to-subnet associations"

  value = {
    for key, association in azurerm_subnet_route_table_association.route_table_association :
    key => {
      id = association.id
    }
  }
}