Add-Type -AssemblyName  System.Windows.Forms
$global:balloon = New-Object System.Windows.Forms.NotifyIcon
Get-Member -InputObject  $Global:balloon
[void](Register-ObjectEvent -InputObject $balloon -EventName MouseDoubleClick -SourceIdentifier IconClicked -Action {

    #Perform  cleanup actions on balloon tip
    $global:balloon.dispose()
    Unregister-Event -SourceIdentifier IconClicked
    Remove-Job -Name IconClicked
    Remove-Variable  -Name balloon -Scope Global
  
  })

$path = (Get-Process -id $pid).Path
$balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
$balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info
$balloon.BalloonTipText = 'All Sitecore 9 prerequisites are installed.'
$balloon.BalloonTipTitle = "Attention, $Env:USERNAME!"
$balloon.Visible  = $true
$balloon.ShowBalloonTip(20000)