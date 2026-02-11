Write-Host "#########################################################"
Write-Host "                                                         "
Write-Host "              Connect to Exchange On-Prem                "
Write-Host "                                                         "
Write-Host "#########################################################"
Write-Host "                                                         "

$exchangeSvr = Read-Host -Prompt "Enter your Exchange Server On-Prem FQDN"
$cred = Get-Credential
$Session = New-PSSession -ConfigurationName Micrososft.Exchange -ConnectionUri http://$exchangeSvr/PowerShell/ -Authentication Kerberos -Credential $cred
Import-PSSession $Session -DisableNameChecking
$Host.UI.RawUI.WindowTitle = "EMS: $exchangeSvr"