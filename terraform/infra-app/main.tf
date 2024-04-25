module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.1"
  prefix  = ["leanix", var.env]
}

# Define the Azure resource group
resource "azurerm_resource_group" "resource_group" {
  name     = module.naming.resource_group.name
  location = var.location
}