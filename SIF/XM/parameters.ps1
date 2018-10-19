# General Params
$prefix                 = 'sc9_xm'
$configsRoot            = Join-Path "$PSScriptRoot" "Configs"
$packagesRoot           = Join-Path "$PSScriptRoot\..\..\..\..\SC9\Packages" "Sitecore 9.0.1 rev. 171219 (WDP XP0 packages)"
$licenseFilePath        = Join-Path "$PSScriptRoot\..\..\..\..\SC9\Packages\License" "license.xml"
$sqlServer              = "$env:COMPUTERNAME"
$SqlAdminUser           = 'SQL_Admin'
$SqlAdminPassword       = 'Pa55w0rd'

# Install Sitecore
$sitecoreStandalone = @{
    Path                = Join-Path $configsRoot sitecore-xm0.json
    Package             = Join-Path $packagesRoot 'Sitecore 9.0.1 rev. 171219 (OnPrem)_single.scwdp.zip'
    LicenseFile         = $licenseFilePath
    SqlDbPrefix         = $prefix
    SiteName            = $prefix
    SqlServer           = $sqlServer
    SqlAdminUser        = $SqlAdminUser
    SqlAdminPassword    = $SqlAdminPassword
}