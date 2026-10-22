variable "virtual_network" {
  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    virtual_network_address_space = list(string)
  }))
}