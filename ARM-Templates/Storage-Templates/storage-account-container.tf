provider "azurerm" {
   features {}
}

data "azurerm_subscription" "current" {}

resource "azurerm_resource_group" "example" {
  name     = "Storage-Setup-Test"
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  account_kind             = "Storage"
  name                     = "kyelorstoraccount"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = "false"
  #public_network_access_enabled   = "false"



  tags = {
    environment = "staging"
  }
}

# resource "azurerm_policy_definition" "example" {
#   name                 = "enforce-no-public-access"
#   policy_type          = "Custom"
#   display_name         = "my-policy-definition"
#   mode                 = "All"
#   policy_rule = <<POLICY_RULE
#   {
#     "if": {
#         "anyOf": [
#           {
#             "field": "type",
#             "equals": "Microsoft.Storage/storageAccounts"
#           },
#           {
#             "field": "Microsoft.Storage/storageAccounts/allowBlobPublicAccess",
#             "equals": true
#           },
#           {
#             "not": {
#               "field": "Microsoft.Storage/storageAccounts/publicNetworkAccess",
#               "equals": "Disabled"
#             }
#           }
#         ]
#     },
#     "then": {
#         "effect": "Deny"
#     }
#   }
#   POLICY_RULE
# }


# resource "azurerm_subscription_policy_assignment" "example" {
#   name                       = "enforce-no-public-access"
#   policy_definition_id       = azurerm_policy_definition.example.id
#   subscription_id            = data.azurerm_subscription.current.id
# }