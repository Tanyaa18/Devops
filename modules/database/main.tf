
resource "azurerm_sql_server" "sql" {
  name                         = "${var.project}-sql-${var.environmentName}"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          ="sqladmin-${var.environmentName}"
  administrator_login_password ="${data.azurerm_key_vault_secret.mySecret.value}"
  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.example.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.example.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = {
    environment = "${var.environmentName}"
  }
}