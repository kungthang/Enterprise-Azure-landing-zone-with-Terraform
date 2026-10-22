variable "public_ip" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method   = string
    sku                 = string
  }))
}

variable "azure_firewall" {
  type = map(object({
    name                  = string
    location              = string
    resource_group_name   = string
    sku_name              = string
    sku_tier              = string
    ip_configuration_name = string
    public_ip_key         = string
  }))
}

variable "firewall_subnet_id" {
  type = string
}