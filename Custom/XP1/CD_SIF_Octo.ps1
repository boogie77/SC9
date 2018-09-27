<# Powershell - Sitecore-Installation-Framework-Script #>
<# Live from the date of 15.05.2018. Adapted and maintained by Dimitar Elenkov, DevOps Engineer @Virtual Affairs #>

param(
[Parameter(Mandatory=$true)]
[string]$FolderRootPath = "",
[Parameter(Mandatory=$true)]
[string]$PSScriptRootPathJson = "",
[Parameter(Mandatory=$true)]
[string]$PSScriptRootPath = "",
[Parameter(Mandatory=$true)]
[string]$Prefix = "",
[Parameter(Mandatory=$true)]
[string]$SitecoreSiteName = "",
[Parameter(Mandatory=$true)]
[string]$SqlDbPrefix = "",
[Parameter(Mandatory=$true)]
[string]$SSLCert = "",
[Parameter(Mandatory=$true)]
[string]$SolrCorePrefix = "",
[Parameter(Mandatory=$true)]
[string]$WinAuthUserSql = "",
[Parameter(Mandatory=$true)]
[string]$WinAuthPasswordSql = "",
[Parameter(Mandatory=$true)]
[string]$SqlServer = "",
[Parameter(Mandatory=$true)]
[string]$EXMCryptographicKey = "",
[Parameter(Mandatory=$true)]
[string]$EXMAuthenticationKey = "",
[Parameter(Mandatory=$true)]
[string]$SolrUrl = "",
[Parameter(Mandatory=$true)]
[string]$XConnectCollectionService = "",
[Parameter(Mandatory=$true)]
[string]$XConnectReferenceDataService = "",
[Parameter(Mandatory=$true)]
[string]$MarketingAutomationOperationsService = "",
[Parameter(Mandatory=$true)]
[string]$MarketingAutomationReportingService = ""
)

#install sitecore instance 
$sitecoreParams = 
@{
    FolderRootPath = $FolderRootPath
    Path = "$PSScriptRootPathJson\sitecore-XP1-cd.json"
    Package = "$PSScriptRootPath\Sitecore 9.0.1 rev. 171219 (OnPrem)_cd.scwdp.zip" 
    LicenseFile = "$PSScriptRootPathJson\license.xml"
    SqlDbPrefix = $SqlDbPrefix
    SSLCert = $SSLCert
    SolrCorePrefix = $SolrCorePrefix
    Sitename = $SitecoreSiteName
    XConnectCert = $SSLCert
    SqlCoreUser = $WinAuthUserSql
    SqlCorePassword = $WinAuthPasswordSql
    SqlWebUser = $WinAuthUserSql
    SqlWebPassword = $WinAuthPasswordSql
    SqlFormsUser = $WinAuthUserSql
    SqlFormsPassword = $WinAuthPasswordSql
    SqlExmMasterUser = $WinAuthUserSql
    SqlExmMasterPassword = $WinAuthPasswordSql
    SqlMessagingUser = $WinAuthUserSql
    SqlMessagingPassword = $WinAuthPasswordSql
    SqlServer = $SqlServer
    EXMCryptographicKey = $EXMCryptographicKey
    EXMAuthenticationKey = $EXMAuthenticationKey
    SolrUrl = $SolrUrl
    XConnectCollectionService = $XConnectCollectionService
    XConnectReferenceDataService = $XConnectReferenceDataService
    MarketingAutomationOperationsService = $MarketingAutomationOperationsService
    MarketingAutomationReportingService = $MarketingAutomationReportingService
    AppPooluserName = $WinAuthUserSql
    AppPoolPassword = $WinAuthPasswordSql
}
Install-SitecoreConfiguration @sitecoreParams -Verbose