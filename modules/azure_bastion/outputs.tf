output "azure_bastion" {
  description = "Details of the created Azure Bastion hosts"

  value = {
    for key, azure_bastion in azurerm_bastion_host.azure_bastion :
    key => {
      id       = azure_bastion.id
      name     = azure_bastion.name
      dns_name = azure_bastion.dns_name
    }
  }
}


output "public_ip" {
  description = "Details of the created Azure Bastion public IP addresses"

  value = {
    for key, public_ip in azurerm_public_ip.public_ip :
    key => {
      id         = public_ip.id
      name       = public_ip.name
      ip_address = public_ip.ip_address
    }
  }
}