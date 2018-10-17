Set-PSRepository -Name PSGallery -InstallationPolicy Trusted  
Install-Module sqlserver -Confirm:$False -AllowClobber
Install-Module dbatools -Confirm:$False -AllowClobber
Import-Module sqlserver  
Import-Module dbatools

$server = "SC9-SRV"
$user = "SQL_Admin"
$LoginType = "SqlLogin"
$pass = ConvertTo-SecureString -String 'Pa55w0rd' -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $pass
Add-SqlLogin -ServerInstance $Server -LoginName $User -LoginType $LoginType -DefaultDatabase tempdb -Enable -GrantConnectSql -LoginPSCredential $Credential  
$svr = New-Object ('Microsoft.SqlServer.Management.Smo.Server') $server
$svrole = $svr.Roles | Where-Object {$_.Name -eq 'sysadmin'}
$svrole.AddMember($user)