# Define Azure SQL Server resource
resource "azurerm_mssql_server" "todo_database_server" {
  name                         = module.naming.sql_server.name
  resource_group_name          = azurerm_resource_group.resource_group.name
  location                     = var.location
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  version                      = "12.0"
}

# Define Azure SQL Database resource
resource "azurerm_mssql_database" "todo_database" {
  name         = module.naming.mssql_database.name
  server_id    = azurerm_mssql_server.todo_database_server.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  sku_name     = "Basic" # Basic DTU-based purchasing model
  license_type = "LicenseIncluded"
}

# Define Azure SQL Server firewall rules
resource "azurerm_mssql_firewall_rule" "azure_ips" {
  name             = "FirewallRule1"
  server_id        = azurerm_mssql_server.todo_database_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}