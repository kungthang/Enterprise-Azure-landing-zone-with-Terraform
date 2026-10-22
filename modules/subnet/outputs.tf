output "subnet" {

  value = {
    for key, subnet in azurerm_subnet.subnet :
    key => {
      id   = subnet.id
      name = subnet.name
    }
  }
}

output "firewall_subnet_id" {

  value = one([
    for subnet in azurerm_subnet.subnet :
    subnet.id
    if subnet.name == "AzureFirewallSubnet"
  ])
}

output "bastion_subnet_id" {
  description = "Resource ID of AzureBastionSubnet"

  value = one([
    for subnet in azurerm_subnet.subnet :
    subnet.id
    if subnet.name == "AzureBastionSubnet"
  ])
}

output "gateway_subnet_id" {
  description = "Resource ID of GatewaySubnet"

  value = one([
    for subnet in azurerm_subnet.subnet :
    subnet.id
    if subnet.name == "GatewaySubnet"
  ])
}

output "application_gateway_subnet_id" {
  description = "Resource ID of ApplicationGatewaySubnet"

  value = one([
    for subnet in azurerm_subnet.subnet :
    subnet.id
    if subnet.name == "ApplicationGatewaySubnet"
  ])
}