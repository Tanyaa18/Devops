resource "azurerm_virtual_network" "onlinetestappvnet" {
   name = var.vnet_name01
   location = var.location
   resource_group_name = "${azurerm_resource_group.test.name}"
   address_space = ["10.0.0.0/16"]
   dns_servers = ["10.0.0.4"]
}

resource "azurerm_network_security_group" "app-nsg" {
    name = "${var.project}-onlinetechchallenge-${var.environmentName}"
    location = var.location
    resource_group_name = var.resource_group

    security_rule {
        name = "ssh-rule-1"
        priority = 100
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_address_prefix = "192.168.1.0/24"
        source_port_range = "*"
        destination_address_prefix = "*"
        destination_port_range = "22"
    }
    
    security_rule {
        name = "rdp-rule-1"
        priority = 101
        direction = "Outbound"
        access = "Allow"
        protocol = "Tcp"
        source_address_prefix = "192.168.1.0/24"
        source_port_range = "*"
        destination_address_prefix = "*"
        destination_port_range = "5895"
    }
}



resource "azurerm_subnet_network_security_group_association" "app-nsg-subnet" {
  subnet_id                 = var.app_subnet_id
  network_security_group_id = azurerm_network_security_group.app-nsg.id
}

resource "azurerm_subnet" "app-subnet" {
   name = "testsubnet"
   resource_group_name = "${azurerm_resource_group.test.name}"
   virtual_network_name = "${azurerm_virtual_network.test.name}"
   address_prefix = "10.0.1.0/24"
   enforce_private_link_endpoint_network_policies = "true"
   delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.Sql/servers"
    }
  }
}
