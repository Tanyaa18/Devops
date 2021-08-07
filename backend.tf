provider "azurerm" {
   subscription_id = "subscription_id-example"
   client_id = "client_id-example"
   client_secret = "client_secret-example"
   tenant_id = "tenant_id-example"
}

data "terraform_remote_state" "myBackend" {
   backend = "azure"
   config {
       storage_account_name = "terraform123abc"
       container_name = "terraform-state"
       key = "prod.terraform.tfstate"
   }
}

resource "azurerm_availability_set" "MyResource" {
   name = "my-MyResource-name"
   resource_group_name = "${azurerm_resource_group.rg.name}"
   location = var.location
}