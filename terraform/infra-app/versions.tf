terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.91.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "leanixgeneric-rg"
    storage_account_name = "leanixgenericst"
    container_name       = "leanixgeneric-stct-tfstate"
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}
