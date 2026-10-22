output "application_gateway" {
  description = "Details of the created Application Gateway"

  value = {
    for key, application_gateway in azurerm_application_gateway.application_gateway :
    key => {
      id   = application_gateway.id
      name = application_gateway.name
    }
  }
}


output "public_ip" {
  description = "Details of the Application Gateway public IP"

  value = {
    for key, public_ip in azurerm_public_ip.public_ip :
    key => {
      id         = public_ip.id
      name       = public_ip.name
      ip_address = public_ip.ip_address
    }
  }
}


output "waf_policy" {
  description = "Details of the Application Gateway WAF policy"

  value = {
    for key, waf_policy in azurerm_web_application_firewall_policy.waf_policy :
    key => {
      id   = waf_policy.id
      name = waf_policy.name
    }
  }
}