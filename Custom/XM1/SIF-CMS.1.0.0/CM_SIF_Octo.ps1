<# Powershell - Sitecore-Installation-Framework-Script #>
<# Live from the date of 15.05.2018. Adapted and maintained by Dimitar Elenkov, DevOps Engineer @Virtual Affairs #>

param(
[Parameter(Mandatory=$true)]
[string]$Prefix = "",
[Parameter(Mandatory=$true)]
[string]$SqlDbPrefix = "",
[Parameter(Mandatory=$true)]
[string]$PSScriptRootPath = "",
[Parameter(Mandatory=$true)]
[string]$SitecoreSiteName = "",
[Parameter(Mandatory=$true)]
[string]$SqlServer = "",
[Parameter(Mandatory=$true)]
[string]$SqlAdminUser = "",
[Parameter(Mandatory=$true)]
[string]$SqlAdminPassword = "",
[Parameter(Mandatory=$true)]
[string]$WinAuthUserSql = "",
[Parameter(Mandatory=$true)]
[string]$WinAuthPasswordSql = "",
[Parameter(Mandatory=$true)]
[string]$FolderRootPath = "",
[Parameter(Mandatory=$true)]
[string]$PSScriptRootPathJson = "",
[Parameter(Mandatory=$true)]
[string]$SSLCert = ""
)

#install sitecore instance 
$sitecoreParams = 
@{     
    Path = "$PSScriptRootPathJson\sitecore-XM1-cm.json"
    Package = "$PSScriptRootPath\Sitecore 9.0.1 rev. 171219 (OnPrem)_cm.scwdp.zip" 
    LicenseFile = "$PSScriptRootPathJson\license.xml"
    SqlDbPrefix = $SqlDbPrefix
    SqlServer = $SqlServer
    Sitename = $sitecoreSiteName
    FolderRootPath = $FolderRootPath
    SqlAdminUser = $SqlAdminUser
    SqlAdminPassword = $SqlAdminPassword
    SqlCoreUser = $WinAuthUserSql
    SqlCorePassword = $WinAuthPasswordSql
    SqlMasterUser = $WinAuthUserSql
    SqlMasterPassword = $WinAuthPasswordSql
    SqlWebUser = $WinAuthUserSql
    SqlWebPassword = $WinAuthPasswordSql
    SqlFormsUser = $WinAuthUserSql
    SqlFormsPassword = $WinAuthPasswordSql
    AppPooluserName = $WinAuthUserSql
    AppPoolPassword = $WinAuthPasswordSql
    SSLCert = $SSLCert
} 
Install-SitecoreConfiguration @sitecoreParams -Verbose