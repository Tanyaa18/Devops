variable "vm_name" {
    description = "name of vms"
    type = list(string)
    default = [ "Nordic-BCG01","AUS-BMFG", "SYD-MIC" ]
  
}

variable "project" {}
variable "environmentName" {}
variable "location" {}
variable "resource_group_name" {}