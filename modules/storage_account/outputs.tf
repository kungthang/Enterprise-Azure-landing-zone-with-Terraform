# ============================================================
# Azure Storage Account Outputs
# ============================================================

output "storage_account" {
  description = "Details of the created Azure Storage Accounts"

  value = {
    for key, storage_account in azurerm_storage_account.storage_account :
    key => {
      id                    = storage_account.id
      name                  = storage_account.name
      primary_blob_endpoint = storage_account.primary_blob_endpoint
      primary_blob_host     = storage_account.primary_blob_host
    }
  }
}