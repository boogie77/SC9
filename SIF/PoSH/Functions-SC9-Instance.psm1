#Create Admin user in SQL
Function Set-CustomSqlAdminUser {
    Param (
        [string]$SqlServer,
        [string]$SqlUser,
        [SecureString]$SqlUserPassword
    )

Import-Module sqlserver  
Import-Module dbatools

$SqlServer = "$env:COMPUTERNAME"
$SqlUser = 'SQL_Admin'
$SqlUserPassword = 'Pa55w0rd'
$loginType = "SqlLogin"
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $SqlUser, $SqlUserPassword
Add-SqlLogin -ServerInstance $SqlServer -LoginName $SqlUser -LoginType $loginType -DefaultDatabase tempdb -Enable -GrantConnectSql -LoginPSCredential $Credential  
$svr = New-Object ('Microsoft.SqlServer.Management.Smo.Server') $SqlServer
$svrole = $svr.Roles | Where-Object {$_.Name -eq 'sysadmin'}
$svrole.AddMember($SqlUser)
}

Export-ModuleMember -function Set-CustomSqlAdminUser