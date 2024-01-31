provider "azurerm" {
   features {}
}

data "azurerm_resource_group" "example"{
  name     = "Storage-Setup-Test"
}

data "azurerm_storage_account" "example" {
  name                     = "kyelorstoraccount"
  resource_group_name      = data.azurerm_resource_group.example.name
}

data "azurerm_policy_definition" "example" {
  name                 = "enforce-no-public-access"
}

# resource "azurerm_resource_policy_assignment" "example" {
#   name                 = "enforce-no-public-access"
#   policy_definition_id = azurerm_policy_definition.example.id
#   resource_id          = azurerm_storage_account.example.id
# }

# resource "azurerm_storage_container" "example" {
#   name                  = "vhds2"
#   storage_account_name  = data.azurerm_storage_account.example.name
#   container_access_type = "container"
# }
