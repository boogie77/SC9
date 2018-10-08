### To Do
### Data-Tier Application Framework [line: 108 - 114]

$DebugPreference = "Continue"

Configuration InstallSC9 {

    param
    (
        [string]
        $LocalPath = "$env:SystemDrive\DSC_Downloads",
        $ISOFolder = "\\SC9-SRV\ShareData",
        $SQLVer = "en_sql_server_2016_developer_with_service_pack_1_x64_dvd_9548071.iso",
        $SQLPath = "$env:SystemDrive\SQL2016DEVSP1"
    )

    # Make sure the DSC Resource modules are downloaded
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
    Import-DscResource -ModuleName 'cChoco'
    Import-DscResource -ModuleName 'SqlServerDsc'

    node localhost {

        # Ensure presence of download folder and log subdirectory
        File CreateDSCFolders {

            Ensure          = "Present"
            Type            = "Directory"
            DestinationPath = "$env:SystemDrive\DSC_Downloads\MSI_Logs"
        }

        # Ensure presence of SQL folder which is target fot the extracted ISO image
        File CreateISOFolders {

            Ensure          = "Present"
            Type            = "Directory"
            DestinationPath = "$SQLPath"
        }

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

        # Install JDK8
        cChocoPackageInstaller installJdk8 {
            Name      = "jdk8"
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

        # Install sql2017-dacframework
        cChocoPackageInstaller sql2017-dacframework {
            Name      = "sql2017-dacframework"
            DependsOn = "[cChocoInstaller]installChoco"
        }

        # Install SQL Server Management Studio
        cChocoPackageInstaller sql-server-management-studio {
            Name      = "sql-server-management-studio"
            DependsOn = "[cChocoInstaller]installChoco"
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

        # Install NuGet Package Explorer
        cChocoPackageInstaller nugetpackageexplorer {
            Name      = "nugetpackageexplorer"
            DependsOn = "[cChocoInstaller]installChoco"
        }

        # Install VSCode
        cChocoPackageInstaller vscode {
            Name      = "vscode"
            DependsOn = "[cChocoInstaller]installChoco"
        }

        # Check prerequisites and mount SQL image file if needed
        Script OpenSQLISO {
            GetScript  =
            {
                $sqlInstances = Get-CimInstance -ClassName win32_service -ComputerName localhost | Where-Object { $_.Name -match "mssql*" -and $_.PathName -match "sqlservr.exe" } | ForEach-Object { $_.Caption }
                $res = $sqlInstances -ne $null -and $sqlInstances -gt 0
                $vals = @{
                    Installed     = $res;
                    InstanceCount = $sqlInstances.count
                }
                $vals
            }

            SetScript  =
            {
                $mountResult = Mount-DiskImage -ImagePath "$using:ISOFolder\$using:SQLVer" -PassThru
                if ($mountResult -eq $null) {
                    throw "Could not mount SQL install ISO image"
                }
                $volumeInfo = $mountResult | Get-Volume
                $driveInfo = Get-PSDrive -Name $volumeInfo.DriveLetter
                $null = Get-PSDrive
                Start-Sleep -Seconds 20
                $JoinPath = Join-Path -Path $driveInfo.Root -ChildPath '*'
                Get-ChildItem -Path $JoinPath | Copy-Item -Destination "$using:SQLPath" -Recurse -Force
                Dismount-DiskImage -ImagePath "$using:ISOFolder\$using:SQLVer" -Verbose
            }

            TestScript =
            {
                $sqlInstances = Get-WmiObject win32_service -computerName localhost | Where-Object { $_.Name -match "mssql*" -and $_.PathName -match "sqlservr.exe" } | ForEach-Object { $_.Caption }
                $res = $sqlInstances -ne $null -and $sqlInstances -gt 0
                if ($res) {
                    Write-Verbose "SQL Server is already installed"
                }
                else {
                    Write-Verbose "SQL Server is not installed"
                }
                $res
            }
        }

        # Install SQL instance
        SqlSetup 'InstallDefaultInstance' {
            InstanceName        = 'MSSQLSERVER'
            Features            = 'SQLENGINE'
            SourcePath          = "$SQLPath"
            SQLSysAdminAccounts = @('Administrators')
            DependsOn           = '[Script]OpenSQLISO'
        }

        # Copy Sitecore 9 SQL databases
    }
}

InstallSC9 -OutputPath .\MOFs\
Start-DscConfiguration -Path ".\MOFs" -Wait -Force -Verbose