Configuration CredentialEncryptExample {
    Param (
        [Parameter(Mandatory=$true)]
        [PSCredential]$Credential
    )
    
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    Node $AllNodes.NodeName
    {
        # Ensure presence of download folder and log subdirectory
        File CreateDSCFolders {

            Ensure          = "Present"
            Type            = "Directory"
            DestinationPath = "$env:SystemDrive\ShareData"
            Credential = $Credential
        }

        LocalConfigurationManager {
            CertificateID = $node.Thumbprint
    
        }
    }
    

}

$configdata = @{
    AllNodes = @(
     @{
      NodeName = "$env:COMPUTERNAME"
      PSDSCAllowPlainTextPassword = $false
      Certificatefile = 'C:\ShareData\CA\SC9-SRV-Target.cer'
      Thumbprint = 'C9843FF7751A7B05FF95C97E165689C8471689EB'   
     }
    )
}

CredentialEncryptExample -OutputPath "C:\CredentialEncryptExample" -configurationdata $configdata `
-Credential (Get-Credential -Message 'Enter Credential for configuration')

Set-DscLocalConfigurationManager -Path C:\CredentialEncryptExample -Verbose -ComputerName $env:COMPUTERNAME

Start-DscConfiguration -Path c:\CredentialEncryptExample -ComputerName $env:COMPUTERNAME -Wait -Force -Verbose