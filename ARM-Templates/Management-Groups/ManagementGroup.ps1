# Create Hashtable of Management Group Details
$managementGroups = 
    @{ DisplayName="Citi"; Name="Citi-Management-Group"; Scope="/"; ParentId="3eec6962-e291-4b13-8682-22962e46f898"; Children=
        @{ DisplayName="Platform"; Name="Platform-Management-Group"; Scope="/"; ParentId="Citi-Management-Group"; Children=
            @{ DisplayName="Management"; Name="Management-Management-Group"; Scope="/"; ParentId="Platform-Management-Group"; Children= @{} },
            @{ DisplayName="Identity"; Name="Identity-Management-Group"; Scope="/"; ParentId="Platform-Management-Group"; Children= @{} },
            @{ DisplayName="Connectivity"; Name="Connectivity-Management-Group"; Scope="/"; ParentId="Platform-Management-Group"; Children= @{} }
         },
        @{ DisplayName="Landing Zones"; Name="Landing-Zones-Management-Group"; Scope="/"; ParentId="Citi-Management-Group"; Children=
            @{ DisplayName="North America"; Name="North-America-Management-Group"; Scope="/"; ParentId="Landing-Zones-Management-Group"; Children=
                @{ DisplayName="Corp"; Name="Corp-Management-Group"; Scope="/"; ParentId="North-America-Management-Group"; Children= @{} },
                @{ DisplayName="Cloud Native"; Name="Cloud-Native-Management-Group"; Scope="/"; ParentId="North-America-Management-Group"; Children= @{} }
            }
        },
        @{ DisplayName="Decommissioned"; Name="Decommissioned-Management-Group"; Scope="/"; ParentId="Citi-Management-Group"; Children= @{} },
        @{ DisplayName="Playground"; Name="Playground-Management-Group"; Scope="/"; ParentId="Citi-Management-Group"; Children= @{} }
    }

function Read-Management-Group {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [System.Object]
        $managementGroupsParam,
        [Parameter(Mandatory=$true)]
        [System.Object]
        $depth
    )

    Process {
        foreach ($mg in $managementGroupsParam) {
            # Create Management Group
            New-AzDeployment -Location EastUS -TemplateFile management-group-template.json `
                -mgName $mg.Name `
                -mgDisplayName $mg.DisplayName `
                -mgScope $mg.Scope `
                -mgParentId $mg.ParentId

            # Output Item
            Write-Host ( "`t{0} was created with ID {1} as a child of {2}" -f $mg.DisplayName, $mg.Name, $mg.ParentId)

            # Recursively go through each child
            if ($mg.Children.count -gt 0) {
                Read-Management-Group -managementGroupsParam $mg.Children -depth ($depth+1)
            }
        }
    }
}

# Call Function
Read-Management-Group -managementGroupsParam $managementGroups -depth 0