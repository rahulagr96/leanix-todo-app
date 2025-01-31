terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.91.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.1"
  prefix  = ["leanixgeneric"]
}