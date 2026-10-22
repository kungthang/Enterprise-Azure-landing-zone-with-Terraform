output "network_security_group" {
  description = "Details of the created network security groups"

  value = {
    for key, network_security_group in azurerm_network_security_group.network_security_group :
    key => {
      id   = network_security_group.id
      name = network_security_group.name
    }
  }
}

output "network_security_rule" {
  description = "Details of the created network security rules"

  value = {
    for key, network_security_rule in azurerm_network_security_rule.network_security_rule :
    key => {
      id   = network_security_rule.id
      name = network_security_rule.name
    }
  }
}