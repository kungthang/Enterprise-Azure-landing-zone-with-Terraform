output "key_vault" {
  description = "Details of the created Azure Key Vaults"

  value = {
    for key, key_vault in azurerm_key_vault.key_vault :
    key => {
      id        = key_vault.id
      name      = key_vault.name
      vault_uri = key_vault.vault_uri
    }
  }
}