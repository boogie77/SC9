### DSC modules below can be obtained from PowerShell Gallery.
$SplitPSModulePath = $env:PSModulePath -split ';'
$PSModulePath = $SplitPSModulePath[1]

### Check PSRepository PSGallery
$PSGalleryRepository = Get-PSRepository -ErrorAction SilentlyContinue | Where-Object {$_.Name -like "PSGallery"}
if(!($PSGalleryRepository)){
    Write-Output "PSRepository called `"PSGallery`" is not present. Starting with the installation."
    Register-PSRepository -Name PSGallery -SourceLocation 'https://www.powershellgallery.com/api/v2' -Verbose -InstallationPolicy Trusted
    Write-Output "PSRepository called `"PSGallery`" installed. Move to the next line."
}
    else{
    Write-Output "PSRepository called `"PSGallery`" is present. Move to the next line."
}

### Check PSRepository NuGet
$PSNugetRepository = Get-PSRepository -ErrorAction SilentlyContinue | Where-Object {$_.Name -like "Nuget"}
if(!($PSNugetRepository)){
    Write-Output "PSRepository called `"Nuget`" is not present. Starting with the installation."
    Register-PSRepository -Name Nuget -SourceLocation 'http://nuget.org/api/v2/' -Verbose -InstallationPolicy Trusted
    Write-Output "PSRepository called `"Nuget`" installed. Move to the next line."
}
    else{
    Write-Output "PSRepository called `"SitecoreGallery`" is present. Move to the next line."
}

### Check PSRepository SitecoreGallery
$PSSitecoreGalleryRepository = Get-PSRepository -ErrorAction SilentlyContinue | Where-Object {$_.Name -like "SitecoreGallery"}
if(!($PSSitecoreGalleryRepository)){
    Write-Output "PSRepository called `"SitecoreGallery`" is not present. Starting with the installation."
    Register-PSRepository -Name SitecoreGallery -SourceLocation 'https://sitecore.myget.org/F/sc-powershell/api/v2' -Verbose -InstallationPolicy Trusted
    Write-Output "PSRepository called `"SitecoreGallery`" installed. Move to the next line."
}
    else{
    Write-Output "PSRepository called `"SitecoreGallery`" is present. Move to the next line."
}

### Check DSC Chocolatey module
$DscModuleChoco = Get-Item -Path "$PSModulePath\*" | Where-Object {$_.Name -like "cChoco"}
if(!($DscModuleChoco)){
    Write-Output "DSC module called `"cChoco`" is not present. Starting with the installation."
    Install-Module -Name cChoco -Force -Verbose
    Write-Output "cChoco module installed. Move to the next line."
}
    else{
    Write-Output "DSC module called `"cChoco`" is present. Move to the next line."
}

### Check DSC SQL module
$DscModuleSqlServer = Get-Item -Path "$PSModulePath\*" | Where-Object {$_.Name -like "SqlServerDsc"}
if(!($DscModuleSqlServer)){
    Write-Output "DSC module called `"SqlServerDsc`" is not present. Starting with the installation."
    Install-Module -Name SqlServerDsc -Force -Verbose
    Write-Output "SqlServerDsc module installed. Move to the next line."
}
    else{
    Write-Output "DSC module called `"SqlServerDsc`" is present. Move to the next line."
}

### Check SqlServer module from PSGallery
$SqlServer = Get-Item -Path "$PSModulePath\*" | Where-Object {$_.Name -eq "SqlServer"}
if(!($SqlServer)){
    Write-Output "PSGallery module called `"SqlServer`" is not present. Starting with the installation."
    Install-Module sqlserver -Confirm:$False -AllowClobber -Force -Verbose
    Write-Output "SqlServer module installed. Move to the next line."
}
    else{
    Write-Output "PSGallery module called `"SqlServer`" is present. Move to the next line."
}
 
### Check dbatools module from PSGallery
$Dbatools = Get-Item -Path "$PSModulePath\*" | Where-Object {$_.Name -eq "dbatools"}
if(!($Dbatools)){
    Write-Output "PSGallery module called `"dbatools`" is not present. Starting with the installation."
    Install-Module dbatools -Confirm:$False -AllowClobber -Force -Verbose
    Write-Output "Dbatools module installed. Move to the next line."
}
    else{
    Write-Output "PSGallery module called `"dbatools`" is present. Move to the next line."
}

### Check PackageManagement module
$PackageManagement = Get-Item -Path "$PSModulePath\*" | Where-Object {$_.Name -like "1.1.7.0"}
if(!($PackageManagement)){
    Write-Output "DSC module called `"PackageManagement Version 1.1.7.0`" is not present. Starting with the installation."
    Install-Module -Name PackageManagement -MinimumVersion '1.1.7.0' -MaximumVersion '1.1.7.0' -Repository PSGallery -Force -Verbose
    Write-Output "PackageManagement module installed. Move to the next line."
}
    else{
    Write-Output "DSC module called `"PackageManagement`" is present. Move to the next line."
}

### Check xPendingReboot module
$xPendingReboot = Get-Item -Path "$PSModulePath\*" | Where-Object {$_.Name -eq "xPendingReboot"}
if(!($xPendingReboot)){
    Write-Output "DSC module called `"xPendingReboot`" is not present. Starting with the installation."
    Install-Module -Name xPendingReboot -Force -Verbose
    Write-Output "xPendingReboot module installed. Move to the next line."
}
    else{
    Write-Output "DSC module called `"xPendingReboot`" is present. Move to the next line."
}

### Check StorageDsc module
$StorageDsc = Get-Item -Path "$PSModulePath\*" | Where-Object {$_.Name -eq "StorageDsc"}
if(!($StorageDsc)){
    Write-Output "DSC module called `"StorageDsc`" is not present. Starting with the installation."
    Install-Module -Name StorageDsc -Force -Verbose
    Write-Output "StorageDsc module installed. Move to the next line."
}
    else{
    Write-Output "DSC module called `"StorageDsc`" is present. Move to the next line."
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

### Check the Sitecore Install Framework module
$SitecoreInstallFramework = Get-Item -Path "$PSModulePath\*" | Where-Object {$_.Name -like "SitecoreInstallFramework"}
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
$SitecoreFundamentals = Get-Item -Path "$PSModulePath\*" | Where-Object {$_.Name -like "SitecoreFundamentals"}
if(!($SitecoreFundamentals)){
    Write-Output "SitecoreFundamentals module is not present. Starting with the installation."
    Install-Module SitecoreFundamentals -Force -Verbose
    Import-Module SitecoreFundamentals -Force -Verbose
    Write-Output "SitecoreFundamentals module installed and imported. Move to the next line."
}
    else{
    Write-Output "SitecoreFundamentals module is present. Move to the next line."
}