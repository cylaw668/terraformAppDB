variable "primary_location" {
  type        = string
  description = "Primary Location"
  default     = "East US"
}

variable "secondary_location" {
  type        = string
  description = "Secondary Location"
  default     = "UK West"
}

variable "env_type" {
  type        = string
  description = "envirnoment"
  default     = "dev"
}

variable "app_service_resource_name" {
  type        = string
  description = "App service resource name"
  default     = "tf_main_rg"
}

variable "app_service_plan_name" {
  type        = string
  description = "Plan name"
  default     = "tfappplan211121"
}

variable "app_service_name" {
    type        = string
    description = "App Service name in Azure"
    default     = "tfappservice211121"
}

variable "sql_server_name" {
    type        = string
    description = "SQL server name"
    default     = "tfsqlserver211121"
}

variable "sql_database_name" {
    type        = string
    description = "SQL Database name"
    default     = "tf_demo_database"
}

variable "sql_admin_login" {
    type        = string
    description = "SQl admin name"
    default     = "adminDemo"
}

variable "sql_admin_password" {
    type        = string
    description = "SQL Database name"
    default     = "D1234@dfg"
}