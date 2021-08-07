
provider "azurerm" {
  version = "~>2.17.0"
  features {}
  skip_provider_registration = true
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
  tags     = var.tags
}

module "compute" {
  source              = "./modules/compute"
  project             = var.project
  environmentName     = var.environmentName
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
}

module "database" {
  source              = "./modules/database"
  project             = var.project
  environmentName     = var.environmentName
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
 
}

module "network" {
  source               = "./modules/network"
  project              = var.project
  environmentName      = var.environmentName
  resource_group_name  = azurerm_resource_group.rg.name
  location             = var.location
}

resource "azurerm_redis_cache" "cache" {
  name                = "${var.project}-redis-${var.environmentName}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  capacity            = 1
  family              = "P"
  sku_name            = "Premium"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {
  }
}

module "keyVault" {
  source              = "./modules/keyVault"
  project             = var.project
  environmentName     = var.environmentName
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
}

module "loadbalancer" {
  source              = "./modules/functionApp"
  project             = var.project
  environmentName     = var.environmentName
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location

}

