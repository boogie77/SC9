#Set SQL Server authentication mode
$WinlUser = Read-Host 'Add here Windows Admin user name?'
$WinUserPassword = Read-Host 'Add here password for the Windows Admin user?' -AsSecureString
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $WinlUser, $WinUserPassword
$sqlCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $SqlUser, $SqlUserPassword
Get-SqlInstance -Credential $Credential -MachineName "$SqlServer" | Set-SqlAuthenticationMode -Credential $Credential -Mode Mixed -SqlCredential $sqlCredential -NoServiceRestart -AcceptSelfSignedCertificate