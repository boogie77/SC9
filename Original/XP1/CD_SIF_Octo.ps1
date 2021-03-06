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
[string]$SitecoreAdminPassword = "",
[Parameter(Mandatory=$true)]
[string]$SqlAdminUser = "",
[Parameter(Mandatory=$true)]
[string]$SqlAdminPassword = "",
[Parameter(Mandatory=$true)]
[string]$WinAuthUserSql = "",
[Parameter(Mandatory=$true)]
[string]$WinAuthPasswordSql = "",
[Parameter(Mandatory=$true)]
[string]$SqlServer = "",
[Parameter(Mandatory=$true)]
[string]$ExmEdsProvider = "",
[Parameter(Mandatory=$true)]
[string]$EXMCryptographicKey = "",
[Parameter(Mandatory=$true)]
[string]$EXMAuthenticationKey = "",
[Parameter(Mandatory=$true)]
[string]$SolrUrl = "",
[Parameter(Mandatory=$true)]
[string]$SolrRoot = "",
[Parameter(Mandatory=$true)]
[string]$SolrService = "",
[Parameter(Mandatory=$true)]
[string]$XConnectCollectionService = "",
[Parameter(Mandatory=$true)]
[string]$XConnectReferenceDataService = "",
[Parameter(Mandatory=$true)]
[string]$MarketingAutomationOperationsService = "",
[Parameter(Mandatory=$true)]
[string]$MarketingAutomationReportingService = "",
[Parameter(Mandatory=$true)]
[string]$TelerikEncryptionKey = ""
)

#install solr cores for sitecore 
$solrParams =
@{
    Path = "$PSScriptRoot\sitecore-solr.json"
    SolrUrl = $SolrUrl
    SolrRoot = $SolrRoot
    SolrService = $SolrService
    CorePrefix = $prefix
} 
Install-SitecoreConfiguration @solrParams -Verbose

#install sitecore instance 
$sitecoreParams = 
@{
    FolderRootPath = $FolderRootPath
    Path = "$PSScriptRootPathJson\sitecore-XM1-cm.json"
    Package = "$PSScriptRootPath\Sitecore 9.0.1 rev. 171219 (OnPrem)_cm.scwdp.zip" 
    LicenseFile = "$PSScriptRootPathJson\license.xml"
    SqlDbPrefix = $SqlDbPrefix
    SSLCert = $SSLCert
    SolrCorePrefix = $prefix
    Sitename = $SitecoreSiteName
    XConnectCert = $SSLCert
    SitecoreAdminPassword = $SitecoreAdminPassword
    SqlAdminUser = $SqlAdminUser
    SqlAdminPassword = $SqlAdminPassword
    SqlCoreUser = $WinAuthUserSql
    SqlCorePassword = $WinAuthPasswordSql
    SqlMasterUser = $WinAuthUserSql
    SqlMasterPassword = $WinAuthPasswordSql
    SqlWebUser = $WinAuthUserSql
    SqlWebPassword = $WinAuthPasswordSql
    SqlReportingUser = $WinAuthUserSql
    SqlReportingPassword = $WinAuthPasswordSql
    SqlProcessingPoolsUser = $WinAuthUserSql
    SqlProcessingPoolsPassword = $WinAuthPasswordSql
    SqlProcessingTasksUser = $WinAuthUserSql
    SqlProcessingTasksPassword = $WinAuthPasswordSql
    SqlReferenceDataUser = $WinAuthUserSql
    SqlReferenceDataPassword = $WinAuthPasswordSql
    SqlMarketingAutomationUser = $WinAuthUserSql
    SqlMarketingAutomationPassword = $WinAuthPasswordSql
    SqlFormsUser = $WinAuthUserSql
    SqlFormsPassword = $WinAuthPasswordSql
    SqlExmMasterUser = $WinAuthUserSql
    SqlExmMasterPassword = $WinAuthPasswordSql
    SqlMessagingUser = $WinAuthUserSql
    SqlMessagingPassword = $WinAuthPasswordSql
    SqlServer = $SqlServer
    ExmEdsProvider = $ExmEdsProvider
    EXMCryptographicKey = $EXMCryptographicKey
    EXMAuthenticationKey = $EXMAuthenticationKey
    SolrUrl =- $SolrUrl
    XConnectCollectionService = $XConnectCollectionService
    XConnectReferenceDataService = $XConnectReferenceDataService
    MarketingAutomationOperationsService = $MarketingAutomationOperationsService
    MarketingAutomationReportingService = $MarketingAutomationReportingService
    TelerikEncryptionKey = $TelerikEncryptionKey
    AppPooluserName = $WinAuthUserSql
    AppPoolPassword = $WinAuthPasswordSql
}
Install-SitecoreConfiguration @sitecoreParams -Verbose