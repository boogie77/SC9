<#
    Install script for XM Single

    All sitecore applications/services are installed on the current VM
    All DBs are installed on the current VM with SqlServer Express instance
#>

# Adding parameters into scope
. $PSScriptRoot\parameters.ps1

### Run installs

# Sitecore Configuration
Install-SitecoreConfiguration @sitecoreStandalone