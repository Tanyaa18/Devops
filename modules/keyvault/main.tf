data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "kv" {
  name                        = "${var.project}-vault-${var.environmentName}"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_enabled         = false
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy = []


}
tags = {
    environment = "${var.environmentName}"
  }
# resource "azurerm_key_vault_secret" "kv" {
#   name         = "X-Api-Key"
#   value        = "94adca9d-a80c-4590-9773-127527490fcf"
#   key_vault_id = azurerm_key_vault.kv.id
# }
