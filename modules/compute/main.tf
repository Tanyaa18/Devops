resource "azurerm_virtual_machine" "vm" {
   name                  = each.value
   for_each              = toset(var.vmname)
   resource_group_name   = "${azurerm_resource_group.vm.name}"
   location              = var.location
   network_interface_ids = ["${azurerm_network_interface.vm.id}"]
   vm_size               = var.vm_size

   storage_image_reference {
       publisher = "Canonical"
       offer     = "UbuntuServer"
       sku       = "14.04.2-LTS"
       version   = "latest"
   }

   storage_os_disk {
       name          = "${each.key}-osdisk"
       vhd_uri       = "${azurerm_storage_account.test.primary_blob_endpoint}${azurerm_storage_container.test.name}/myosdisk1.vhd"
       caching       = "ReadWrite"
       create_option = "FromImage"
   }

   storage_data_disk {
       name          = "${each.key}-datadisk"
       vhd_uri       = "${azurerm_storage_account.test.primary_blob_endpoint}${azurerm_storage_container.test.name}/datadisk0.vhd"
       disk_size_gb  = "1023"
       create_option = "empty"
       lun           = 0
   }

   os_profile {
       computer_name  = "${each.value}"
       admin_username = "${each.key}-admin"
       admin_password = "${data.azurerm_key_vault_secret.mySecret.value}"
   }

   os_profile_linux_config {
       disable_password_authentication = false
   }
}

tags = {
    environment = "${var.environmentName}"
  }