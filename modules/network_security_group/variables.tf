variable "network_security_group" {
  description = "Network security group values received from the root module"

  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
  }))
}


variable "network_security_rule" {
  description = "Network security rule values received from the root module"

  type = map(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    resource_group_name        = string
    network_security_group_key = string
  }))
}


variable "subnet_id" {
  description = "Map of subnet IDs used for NSG associations"
  type        = map(string)
}