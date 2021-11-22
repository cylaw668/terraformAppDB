terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf_resource_rg" {
  name     = var.app_service_resource_name
  location = var.primary_location
  tags = {
    environment = var.env_type
    source      = "Terraform"
  }
}

resource "azurerm_app_service_plan" "tf_app_plan"{
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.tf_resource_rg.location
  resource_group_name = azurerm_resource_group.tf_resource_rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }          
}

resource "azurerm_app_service" "tf_app_service" {
  name                = var.app_service_name
  location            = azurerm_resource_group.tf_resource_rg.location
  resource_group_name = azurerm_resource_group.tf_resource_rg.name
  app_service_plan_id = azurerm_app_service_plan.tf_app_plan.id

  site_config {
    dotnet_framework_version = "v5.0"
    scm_type                 = "LocalGit"
  }

  app_settings = {
    "SOME_KEY" = "some-value"
  }

  connection_string {
    name  = "Database"
    type  = "SQLAzure"
    value = "Server=tcp:azurerm_sql_server.tf_sql_server.fully_qualified_domain_name Database=azurerm_sql_database.tf_sql_db.name;User ID=azurerm_sql_server.tf_sql_server.administrator_login;Password=azurerm_sql_server.tf_sql_server.administrator_login_password;Trusted_Connection=False;Encrypt=True;"
  }
}

resource "azurerm_sql_server" "tf_sql_server" {
  name                          = var.sql_server_name
  location                      = azurerm_resource_group.tf_resource_rg.location
  resource_group_name           = azurerm_resource_group.tf_resource_rg.name
  version                       = "12.0"
  administrator_login           = var.sql_admin_login
  administrator_login_password  = var.sql_admin_password
}

resource "azurerm_sql_database" "tf_sql_db" {
  name                          = var.sql_database_name
  location                      = azurerm_resource_group.tf_resource_rg.location
  resource_group_name           = azurerm_resource_group.tf_resource_rg.name
  server_name                   = azurerm_sql_server.tf_sql_server.name
}