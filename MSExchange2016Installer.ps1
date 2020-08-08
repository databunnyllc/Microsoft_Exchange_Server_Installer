# Prompt users that they are about to install Microsoft Exchange 2016 and gives them a choice between or no.
# Yes or No. Yes will continue with the installation phase.

Write-Host "You are about to install Microsoft Exchange Server 2016"
$InstallChoice = Read-Host "DO YOU WANT TO CONTINUE?: [y/n]"

$DriveChoice = Read-Host "WHAT DRIVE IS EXCHANGE ON? (NO NEED TO TYPE COLON):"
cd $DriveChoice":"

switch ($InstallChoice) {
    ($InstallChoice = "y") {
        # Checks the computer's execution policy.
        Write-Host "CHECKING EXECUTION POLICY"
        Get-ExecutionPolicy
        Write-Host "SETTING EXECUTION POLICY TO REMOTESIGNED."
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned 
        Get-ExecutionPolicy
        Write-Host "NOW INITIATING INSTALL."

        #Initiating Install of Exchange Server 2016.
        Install-WindowsFeature RSAT-ADDS

        #Installing Required Roles.
        Write-Host "INSTALLING REQUIRED ROLES"
        
        Install-WindowsFeature NET-Framework-45-Features 
        Install-WindowsFeature RPC-over-HTTP-proxy 
        Install-WindowsFeature RSAT-Clustering 
        Install-WindowsFeature RSAT-Clustering-CmdInterface 
        Install-WindowsFeature RSAT-Clustering-Mgmt 
        Install-WindowsFeature RSAT-Clustering-PowerShell 
        Install-WindowsFeature Web-Mgmt-Console 
        Install-WindowsFeature WAS-Process-Model 
        Install-WindowsFeature Web-Asp-Net45
        Install-WindowsFeature Web-Basic-Auth 
        Install-WindowsFeature Web-Client-Auth 
        Install-WindowsFeature Web-Digest-Auth 
        Install-WindowsFeature Web-Dir-Browsing 
        Install-WindowsFeature Web-Dyn-Compression
        Install-WindowsFeature Web-Http-Errors 
        Install-WindowsFeature Web-Http-Logging 
        Install-WindowsFeature Web-Http-Redirect
        Install-WindowsFeature Web-Http-Tracing 
        Install-WindowsFeature Web-ISAPI-Ext 
        Install-WindowsFeature Web-ISAPI-Filter 
        Install-WindowsFeature Web-Lgcy-Mgmt-Console 
        Install-WindowsFeature Web-Metabase 
        Install-WindowsFeature Web-Mgmt-Console
        Install-WindowsFeature Web-Mgmt-Service
        Install-WindowsFeature Web-Net-Ext45 
        Install-WindowsFeature Web-Request-Monitor
        Install-WindowsFeature Web-Server 
        Install-WindowsFeature Web-Stat-Compression 
        Install-WindowsFeature Web-Static-Content 
        Install-WindowsFeature Web-Windows-Auth 
        Install-WindowsFeature Web-WMI
        Install-WindowsFeature Windows-Identity-Foundation
        Install-WindowsFeature RSAT-ADDS

        Write-Host "PREPARING SCHEMA"

        .\setup /PrepareSchema /IAcceptExchangeServerLicenseTerms

        .\setup /Preparead /IAcceptExchangeServerLicenseTerms /OrganizationName:"COMPANY"

        .\setup /Preparedomain /IAcceptExchangeServerLicenseTerms
    }
    ($InstallChoice = "n") {
        Write-Host "ENDING PROCESS"
        Write-Host "GOODBYE!"
    }
    default: {
        Write-Host "NO CHOICE SELECTED...ENDING PROCESS."
    }
}
