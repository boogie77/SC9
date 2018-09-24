<# Powershell - Sitecore-Installation-Framework-Script, XConnect instance setup #>
<# Live from the date of 17.09.2018. Adapted and maintained by Dimitar Elenkov, DevOps Engineer @Virtual Affairs #>

param(
[Parameter(Mandatory=$true)]
[string]$prefix,
[Parameter(Mandatory=$true)]
[string]$SqlDbPrefix,
[Parameter(Mandatory=$true)]
[string]$XConnectCollectionService,
[Parameter(Mandatory=$true)]
[string]$PSScriptRootPath,
[Parameter(Mandatory=$true)]
[string]$SqlServer,
[Parameter(Mandatory=$true)]
[string]$WinAuthUserSql,
[Parameter(Mandatory=$true)]
[string]$WinAuthPasswordSql,
[Parameter(Mandatory=$true)]
[string]$SqlAdminUser,
[Parameter(Mandatory=$true)]
[string]$SqlAdminPassword,
[Parameter(Mandatory=$true)]
[string]$FolderRootPath,
[Parameter(Mandatory=$true)]
[string]$PSScriptRootPathJson,
[Parameter(Mandatory=$true)]
[string]$SolrUrl,
[Parameter(Mandatory=$true)]
[string]$SolrRoot,
[Parameter(Mandatory=$true)]
[string]$SolrService,
[Parameter(Mandatory=$true)]
[string]$SslCert,
[Parameter(Mandatory=$true)]
[string]$XConnectEnv
)

#install solr cores for xdb
$solrParams =
@{
    Path = "$PSScriptRootPath\JsonFiles\xconnect-solr.json"
    SolrUrl = $SolrUrl
    SolrRoot = $SolrRoot
    SolrService = $SolrService
    CorePrefix = $prefix
} 
Install-SitecoreConfiguration @solrParams -Verbose

#deploy xconnect instance
$xconnectParams =
@{
    Path = "$PSScriptRootPath\JsonFiles\xconnect-xp0.json"
    Package = "$PSScriptRootPath\Sitecore 9.0.1 rev. 171219 (OnPrem)_xp0xconnect.scwdp.zip"
    LicenseFile = "$PSScriptRootPath\JsonFiles\license.xml"
    Sitename = $XConnectCollectionService
    FolderRootPath = $FolderRootPath
    XConnectCert = $SslCert
    SqlDbPrefix = $SqlDbPrefix
    SqlServer = $SqlServer
    SqlAdminUser = $SqlAdminUser
    SqlAdminPassword = $SqlAdminPassword
    SolrCorePrefix = $prefix
    SolrURL = $SolrUrl
    SqlCollectionUser = $WinAuthUserSql
    SqlCollectionPassword = $WinAuthPasswordSql
    SqlProcessingPoolsUser = $WinAuthUserSql
    SqlProcessingPoolsPassword = $WinAuthPasswordSql
    SqlReferenceDataUser = $WinAuthUserSql
    SqlReferenceDataPassword = $WinAuthPasswordSql
    SqlMarketingAutomationUser = $WinAuthUserSql
    SqlMarketingAutomationPassword = $WinAuthPasswordSql
    SqlMessagingUser = $WinAuthUserSql
    SqlMessagingPassword = $WinAuthPasswordSql
    XConnectEnvironment = $XConnectEnv
    AppPooluserName = $WinAuthUserSql
    AppPoolPassword = $WinAuthPasswordSql
}
Install-SitecoreConfiguration @xconnectParams -Verbose