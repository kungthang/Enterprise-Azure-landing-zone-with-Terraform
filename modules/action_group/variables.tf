variable "action_group" {
  description = "Configuration for Azure Monitor Action Groups"

  type = map(object({
    name                = string
    resource_group_name = string
    short_name          = string

    email_receivers = map(object({
      name                    = string
      email_address           = string
      use_common_alert_schema = bool
    }))

    tags = map(string)
  }))
}