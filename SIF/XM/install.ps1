<#
    Install script for XM Single

    All sitecore applications/services are installed on the current VM
    All DBs are installed on the current VM with SqlServer Developer instance
#>

# Import functions to do actual installation
$scriptDir = "$PSScriptRoot\..\DSC\Install-with-SQL"
Import-Module $scriptDir\Functions-SC9-Instance.psm1


# Adding SC9 parameters into scope
. $PSScriptRoot\parameters.ps1

### Run installs

# Set Admin User in SQL
Set-CustomSqlAdminUser -SqlServer $SqlServer -SqlUser $SqlUser -SqlUserPassword $SqlUserPassword

# Set contained database authentication to 1 value
"$SqlServer" | Invoke-DbaQuery -File "$configsRoot\SQL-Query.sql"

# Sitecore Configuration
Install-SitecoreConfiguration @sitecoreStandalone