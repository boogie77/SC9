### The modules can be obtained from PowerShell Gallery.

### Installing WebAdministration module related to use of SIF
# Adding Web-Server Windows feature
Install-WindowsFeature -Name Web-Server -Verbose -ErrorAction SilentlyContinue

# Adding all needed DSC modules
Install-Module -Name cChoco -Force -Verbose

### The modules can be obtained from the Sitecore MyGet repository.
# Add the Sitecore MyGet repository to PowerShell
Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2 -Verbose -InstallationPolicy Trusted

# Install the Sitecore Install Framwork module
Install-Module SitecoreInstallFramework -Force -Verbose

# Install the Sitecore Fundamentals module (provides additional functionality for local installations like creating self-signed certificates)
Install-Module SitecoreFundamentals -Force -Verbose

# Import the modules into your current PowerShell context (if necessary)
Import-Module SitecoreFundamentals -Force -Verbose
Import-Module SitecoreInstallFramework -Force -Verbose