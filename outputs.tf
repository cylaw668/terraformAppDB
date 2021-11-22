output "webapp_url" {
    value = azurerm_app_service.tf_app_service.default_site_hostname
}

output "webapp_ips" {
    value = azurerm_app_service.tf_app_service.outbound_ip_addresses
}

output "sql_server_id"{
    value = azurerm_sql_server.azurerm_sql_database.id
}