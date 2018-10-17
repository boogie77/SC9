# General Params
$prefix                 = 'sc9_xm'
$configsRoot            = Join-Path "$PSScriptRoot" "Configs"
$packagesRoot           = Join-Path "$PSScriptRoot\..\..\..\..\SC9\Packages" "Sitecore 9.0.1 rev. 171219 (WDP XP0 packages)"
$licenseFilePath        = Join-Path "$PSScriptRoot\..\..\..\..\SC9\Packages" "license.xml"
$sqlServer              = "$SqlServer"

# Install Sitecore
$sitecoreStandalone = @{
    Path                = Join-Path $configsRoot sitecore-xm0.json
    Package             = Join-Path $packagesRoot 'Sitecore 9.0.1 rev. 171219 (OnPrem)_single.scwdp.zip'
    LicenseFile         = $licenseFilePath
    SqlDbPrefix         = $prefix
    SiteName            = $prefix
    SqlServer           = $sqlServer
}