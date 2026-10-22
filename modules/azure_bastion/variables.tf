# ============================================================
# Azure Bastion Public IP
# ============================================================

variable "public_ip" {
  description = "Configuration for Azure Bastion public IP addresses"

  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method   = string
    sku                 = string
    tags                = map(string)
  }))
}


# ============================================================
# Azure Bastion Host
# ============================================================

variable "azure_bastion" {
  description = "Configuration for Azure Bastion hosts"

  type = map(object({
    name                  = string
    location              = string
    resource_group_name   = string
    sku                   = string
    copy_paste_enabled    = bool
    file_copy_enabled     = bool
    ip_configuration_name = string
    public_ip_key         = string
    tags                  = map(string)
  }))
}


# ============================================================
# Azure Bastion Subnet
# ============================================================

variable "bastion_subnet_id" {
  description = "Resource ID of AzureBastionSubnet"
  type        = string
}