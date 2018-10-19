<#
    Install script for XM Single

    All sitecore applications/services are installed on the current VM
    All DBs are installed on the current VM with SqlServer Developer instance
#>

# Adding SC9 parameters into scope
. $PSScriptRoot\parameters.ps1

# Install Sitecore
Install-SitecoreConfiguration @sitecoreStandalone