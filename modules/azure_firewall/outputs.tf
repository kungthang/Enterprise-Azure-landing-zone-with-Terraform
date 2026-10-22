output "azure_firewall" {
  description = "Details of the created Azure Firewall"

  value = {
    for key, azure_firewall in azurerm_firewall.azure_firewall :
    key => {
      id         = azure_firewall.id
      name       = azure_firewall.name
      private_ip = azure_firewall.ip_configuration[0].private_ip_address
    }
  }
}