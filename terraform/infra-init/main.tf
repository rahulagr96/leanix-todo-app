# Define Azure resource group
resource "azurerm_resource_group" "resource_group" {
  name     = module.naming.resource_group.name
  location = var.location
}

# Define Azure storage account for Terraform state
resource "azurerm_storage_account" "tfstate" {
  name                     = module.naming.storage_account.name
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  blob_properties {
    versioning_enabled = true
  }
}

# Define Azure storage container for Terraform state
resource "azurerm_storage_container" "tfstate" {
  name                  = "${module.naming.storage_container.name}-tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "blob"
}
