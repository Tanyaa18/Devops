rresource "azurerm_lb" "lb" {
   name = "${var.project}-lb-${var.environmentName}"
   location = var.location
   resource_group_name = var.resource_group_name
}

resource "azurerm_lb_backend_address_pool" "lb_backendpool" {
   name = "BackEndAddressPool"
   location = var.location
   resource_group_name = var.resource_group_name
   loadbalancer_id = "${azurerm_lb.lb.id}"
}

resource "azurerm_lb_rule" "lb_rules" {
   name = "onlineapp lb rule"
   location = var.location
   resource_group_name = var.resource_group_name
   loadbalancer_id = "${azurerm_lb.lb.id}"
   protocol = "Tcp"
   frontend_port = 3389
   backend_port = 3389
   frontend_ip_configuration_name = "PublicIPAddress"
}
resource "azurerm_lb_probe" "MyResource" {
   name = "SSH Running Probe"
   location = var.location
   resource_group_name = var.resource_group_name
   loadbalancer_id = "${azurerm_lb.lb.id}"
   port = 22
}

