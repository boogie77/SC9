$DebugPreference = "Continue"

Configuration InstallSC9 {

    param
    (
        [string]
        $LocalPath = "$env:SystemDrive\DSC_Downloads"
    )

    # Make sure the DSC Resource modules are downloaded
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName 'cChoco'
    
    node localhost {

        # Install .NET 3.5
        WindowsFeature NetFrameworkCore {
            Ensure = "Present" 
            Name   = "NET-Framework-Core"
        }

        # Install .NET 4.6
        WindowsFeature 'NetFramework45' {
            Name   = 'NET-Framework-45-Core'
            Ensure = 'Present'
        }

        # Install Web Management Service
        WindowsFeature WebManagementService {
            Ensure = "Present"
            Name   = "Web-Mgmt-Service"
        }

        # Ensure presence of download folder and log subdirectory
        File CreateDSCFolders {

            Ensure          = "Present"
            Type            = "Directory"
            DestinationPath = "$env:SystemDrive\DSC_Downloads\MSI_Logs"
        }

        # Downalod Web Deploy 3.6
        Script DownloadMsi {
            GetScript  = 
            {
                @{
                    GetScript  = $GetScript
                    SetScript  = $SetScript
                    TestScript = $TestScript
                    Result     = ('True' -in ("$using:LocalPath\WebDeploy_amd64_en-US.msi"))
                }
            }
        
            SetScript  = 
            {
                $WebDeployUri = "https://download.microsoft.com/download/0/1/D/01DC28EA-638C-4A22-A57B-4CEF97755C6C/WebDeploy_amd64_en-US.msi"
                Invoke-WebRequest -Uri "$using:WebDeployUri" -OutFile "$using:LocalPath\WebDeploy_amd64_en-US.msi"
            }
        
            TestScript = 
            {
                $Status = ('True' -in ("$using:LocalPath\WebDeploy_amd64_en-US.msi"))
                $Status -eq $True
            }
        }

        # Install Web Deploy 3.6
        Package Installer {
            Ensure    = 'Present'
            Name      = "Microsoft Web Deploy 3.6"
            Path      = "$LocalPath\WebDeploy_amd64_en-US.msi"
            LogPath   = "$LocalPath\MSI_Logs\logoutput.txt"
            Arguments = "LicenseAccepted='0' ADDLOCAL=ALL"
            ProductId = "6773A61D-755B-4F74-95CC-97920E45E696"
            DependsOn = "[Script]DownloadMsi"
        }

        # Install Chocolatey
        cChocoInstaller installChoco {
            InstallDir = "c:\choco"
            DependsOn  = "[WindowsFeature]NetFrameworkCore"
        }

        # Install dotnet4.7.1
        cChocoPackageInstaller dotnet471 {
            Name      = "dotnet4.7.1"
            DependsOn = "[cChocoInstaller]installChoco"
        }
        
        # Visual C++ Redistributable for VS 2017 14.12.25810
        cChocoPackageInstaller vcredist140 {
            Name      = "vcredist140"
            DependsOn = "[cChocoInstaller]installChoco"
        }

        # Install JRE8
        cChocoPackageInstaller installJre8 {
            Name      = "jre8"
            DependsOn = "[cChocoInstaller]installChoco"
        }

        # Install urlrewrite
        cChocoPackageInstaller installurlrewrite {
            Name      = "urlrewrite"
            DependsOn = "[cChocoInstaller]installChoco"
        }

        # Install sql2016-dacframework
        cChocoPackageInstaller sql2016-dacframework {
            Name      = "sql2016-dacframework"
            DependsOn = "[cChocoInstaller]installChoco"
        }

        # Install NuGet Package Explorer
        cChocoPackageInstaller nugetpackageexplorer {
            Name      = "nugetpackageexplorer"
            DependsOn = "[cChocoInstaller]installChoco"
        }
    }
}

Remove-Item -Path ".\MOFs\InstallSC9" -Verbose -Force -ErrorAction SilentlyContinue
InstallSC9 -OutputPath ".\MOFs\InstallSC9"
Start-DscConfiguration -Path ".\MOFs\InstallSC9" -Wait -Force -Verbose