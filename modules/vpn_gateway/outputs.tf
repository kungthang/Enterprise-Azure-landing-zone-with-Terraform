output "vpn_gateway" {
  description = "Details of the created VPN Gateway"

  value = {
    for key, vpn_gateway in azurerm_virtual_network_gateway.vpn_gateway :
    key => {
      id   = vpn_gateway.id
      name = vpn_gateway.name
    }
  }
}


output "public_ip" {
  description = "Details of the created VPN Gateway public IP addresses"

  value = {
    for key, public_ip in azurerm_public_ip.public_ip :
    key => {
      id         = public_ip.id
      name       = public_ip.name
      ip_address = public_ip.ip_address
    }
  }
}