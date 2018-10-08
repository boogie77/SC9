### DSC modules below can be obtained from PowerShell Gallery.
$DSCModulesPath = 'C:\Program Files\WindowsPowerShell\Modules'

### Check DSC Chocolatey module
$DscModuleChoco = Get-Item -Path "$DSCModulesPath\*" | Where-Object {$_.Name -like "*Choco*"}
if(!($DscModuleChoco)){
    Write-Output "DSC module called `"Choco`" is not present. Starting with the installation."
    Install-Module -Name cChoco -Force -Verbose
    Write-Output "Choco module installed. Move to the next line."
}
    else{
    Write-Output "DSC module called `"Choco`" is present. Move to the next line."
}

### Check DSC SQL module
$DscModuleSqlServer = Get-Item -Path "$DSCModulesPath\*" | Where-Object {$_.Name -like "*SqlServerDsc*"}
if(!($DscModuleSqlServer)){
    Write-Output "DSC module called `"SqlServerDsc`" is not present. Starting with the installation."
    Install-Module -Name SqlServerDsc -Force -Verbose
    Write-Output "SqlServerDsc module installed. Move to the next line."
}
    else{
    Write-Output "DSC module called `"SqlServerDsc`" is present. Move to the next line."
}

### Modules below can be obtained from the Sitecore MyGet repository.
### Check Package Provider NuGet
$PackageProvider = Find-PackageProvider -Name NuGet | Where-Object {$_.Version -ge "2.8.5.201"}
if(!($PackageProvider)){
    Write-Output "Package Provider `"NuGet Minimum Version: 2.8.5.201`" is not present. Starting with the installation."
    Install-PackageProvider -Name NuGet -MinimumVersion "2.8.5.201" -Force -Verbose
    $NugetVersion = Find-PackageProvider -Name NuGet
    Write-Output "Package Provider NuGet with Version: `"$($NugetVersion.Version)`" installed. Move to the next line."
}
    else{
    Write-Output "Package Provider `"NuGet with Version: `"$($PackageProvider.Version)`" is present. Move to the next line."
}

### Check PSRepository SitecoreGallery
$PSRepository = Get-PSRepository -ErrorAction SilentlyContinue | Where-Object {$_.Name -ge "SitecoreGallery"}
if(!($PSRepository)){
    Write-Output "PSRepository called `"SitecoreGallery`" is not present. Starting with the installation."
    Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2 -Verbose -InstallationPolicy Trusted
    Write-Output "PSRepository called `"SitecoreGallery`" installed. Move to the next line."
}
    else{
    Write-Output "PSRepository called `"SitecoreGallery`" is present. Move to the next line."
}

### Installing WebAdministration module related to use of SIF
### Check Web-Server Windows feature
$TestWebServerFeature = Get-WindowsFeature -Name "Web-Server" | Where-Object {$_.Installed -eq $true}
if(!($TestWebServerFeature)){
    Write-Output "Web-Server feature is not present. Starting with the installation."
        Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools -Verbose
    Write-Output "Web-Server feature installed. Move to the next line."
}
    else{
    Write-Output "Web-Server feature is present. Move to the next line."
}

### Check the Sitecore Install Framwork module
$SitecoreInstallFramework = Get-Item -Path "$DSCModulesPath\*" | Where-Object {$_.Name -like "SitecoreInstallFramework"}
if(!($SitecoreInstallFramework)){
    Write-Output "SitecoreInstallFramework module is not present. Starting with the installation."
    Install-Module SitecoreInstallFramework -Force -Verbose
    Import-Module SitecoreInstallFramework -Force -Verbose
    Write-Output "SitecoreInstallFramework module installed and imported. Move to the next line."
}
    else{
    Write-Output "SitecoreInstallFramework module is present. Move to the next line."
}

### Check the Sitecore Fundamentals module (provides additional functionality for local installations like creating self-signed certificates)
$SitecoreFundamentals = Get-Item -Path "$DSCModulesPath\*" | Where-Object {$_.Name -like "SitecoreFundamentals"}
if(!($SitecoreFundamentals)){
    Write-Output "SitecoreFundamentals module is not present. Starting with the installation."
    Install-Module SitecoreFundamentals -Force -Verbose
    Import-Module SitecoreFundamentals -Force -Verbose
    Write-Output "SitecoreFundamentals module installed and imported. Move to the next line."
}
    else{
    Write-Output "SitecoreFundamentals module is present. Move to the next line."
}