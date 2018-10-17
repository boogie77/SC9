#Create Admin user in SQL
Function Set-CustomSqlAdminUser {
    Param (
        [string]$SqlServer,
        [string]$SqlUser,
        [SecureString]$SqlUserPassword
    )

Import-Module sqlserver  
Import-Module dbatools

$SqlServer = Read-Host 'Add here SQL server instance?'
$SqlUser = Read-Host 'Add here SQL user name?'
$SqlUserPassword = Read-Host 'Add here password for the user?' -AsSecureString
$loginType = "SqlLogin"
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $SqlUser, $SqlUserPassword
Add-SqlLogin -ServerInstance $SqlServer -LoginName $SqlUser -LoginType $loginType -DefaultDatabase tempdb -Enable -GrantConnectSql -LoginPSCredential $Credential  
$svr = New-Object ('Microsoft.SqlServer.Management.Smo.Server') $SqlServer
$svrole = $svr.Roles | Where-Object {$_.Name -eq 'sysadmin'}
$svrole.AddMember($SqlUser)
}

Export-ModuleMember -function Set-CustomSqlAdminUser