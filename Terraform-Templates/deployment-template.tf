provider "azurerm" {
   features {}
}

resource "azurerm_resource_group" "example" {
  name     = "Storage-Setup-Test"
  location = "East US"
}
resource "azurerm_template_deployment" "example" {
  name                = "acctesttemplate-01"
  resource_group_name = azurerm_resource_group.example.name

  template_body = <<DEPLOY
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
      "_generator": {
        "name": "bicep",
        "version": "0.13.1.58284",
        "templateHash": "13120038605368246703"
      }
    },
    "parameters": {
      "storageAccountType": {
        "type": "string",
        "defaultValue": "Standard_LRS",
        "allowedValues": [
          "Premium_LRS",
          "Premium_ZRS",
          "Standard_GRS",
          "Standard_GZRS",
          "Standard_LRS",
          "Standard_RAGRS",
          "Standard_RAGZRS",
          "Standard_ZRS"
        ],
        "metadata": {
          "description": "Storage Account type"
        }
      },
      "location": {
        "type": "string",
        "defaultValue": "[resourceGroup().location]",
        "metadata": {
          "description": "The storage account location."
        }
      },
      "storageAccountName": {
        "type": "string",
        "defaultValue": "kyelorstorageaccounttest",
        "metadata": {
          "description": "The name of the storage account"
        }
      }
    },
    "resources": [
      {
        "type": "Microsoft.Storage/storageAccounts",
        "apiVersion": "2022-09-01",
        "name": "[parameters('storageAccountName')]",
        "location": "[parameters('location')]",
        "sku": {
          "name": "[parameters('storageAccountType')]"
        },
        "kind": "Storage",
        "properties": {
            "allowBlobPublicAccess": false
        }
      }
    ],
    "outputs": {
      "storageAccountName": {
        "type": "string",
        "value": "[parameters('storageAccountName')]"
      },
      "storageAccountId": {
        "type": "string",
        "value": "[resourceId('Microsoft.Storage/storageAccounts', parameters('storageAccountName'))]"
      }
    }
  }
DEPLOY


  # these key-value pairs are passed into the ARM Template's `parameters` block
  parameters = {
    "storageAccountType" = "Standard_LRS"
  }

  deployment_mode = "Complete"
}

output "storageAccountName" {
  value = azurerm_template_deployment.example.outputs["storageAccountName"]
}