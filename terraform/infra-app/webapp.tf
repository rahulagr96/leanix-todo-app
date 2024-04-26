# Define Azure App Service Plan resource
resource "azurerm_service_plan" "service_plan" {
  name                = module.naming.app_service_plan.name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  sku_name            = "F1" # Free tier
  os_type             = "Linux"
}

# Define Azure Linux Web App resource
resource "azurerm_linux_web_app" "todoapp" {
  name                = "${var.env}leanixtodoapp"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  service_plan_id     = azurerm_service_plan.service_plan.id
  https_only          = true
  # Disable basic authentication for FTP publish
  ftp_publish_basic_authentication_enabled = false
  # Disable basic authentication for WebDeploy publish
  webdeploy_publish_basic_authentication_enabled = false

  # Configuration settings for the web app
  site_config {
    ftps_state = "FtpsOnly"
    health_check_path = "/api/todos/health"
    health_check_eviction_time_in_min = 5

    application_stack {
      java_version        = "17"
      java_server         = "JAVA"
      java_server_version = "17"
    }
    always_on = false
  }
}
