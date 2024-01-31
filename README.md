
# Azure Templates

This GitHub Repo contains the templates created for Azure IaC POCs. These files are used on a Non-Citi Azure Account to test the functionalities and research the different possibilities of resource deployment.




## Important Notes

Azure Deployment Templates can be deployed using different modes: Complete or Incremental. Depending on the mode chosen it can affect how the resources are either created or changed.

In complete mode, Resource Manager deletes resources that exist in the resource group but aren't specified in the template.

In incremental mode, Resource Manager leaves unchanged resources that exist in the resource group but aren't specified in the template. Resources in the template are added to the resource group.


## Installation

Install Azure CLI

```bash
  https://learn.microsoft.com/en-us/cli/azure/install-azure-cli
```
    

Install Azure Powershell

```bash
  Install-Module -Name Az -Repository PSGallery -Force
  Update-Module -Name Az -Force
```

Install Terraform

```bash
  https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
```
## Authors

- Kyelor Curtis [@kyelor-curtis](https://www.github.com/kyelor-curtis)

