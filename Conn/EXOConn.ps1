Write-Host "#########################################################"
Write-Host "                                                         "
Write-Host "            Connect to Exchange Online                   "
Write-Host "                                                         "
Write-Host "#########################################################"
Write-Host "                                                         "

if(-not(Get-Module ExchangeOnlineManagement -ListAvailable)){
    Write-Host "Exchange Online PowerShell module is not installed."
    Write-Host "Installing required module..."

    try{
        Import-Module -Name ExchangeOnlineManagement -ErrorAction Stop
        Write-Host "Exchange Online PowerShell module installed successfully."
        $usrCred = Get-Credential
        Connect-ExchangeOnline -UserPrincipalName $usrCred.UserName -ShowProgress $true
        $Host.UI.RawUI.WindowTitle = "Exchange Online"        
    }
    catch {
        Write-Host "Error installing module: $($_.Exception.Message)"
    }
}else{
    $usrCred = Get-Credential
    Connect-ExchangeOnline -UserPrincipalName $usrCred.UserName -ShowProgress $true
    $Host.UI.RawUI.WindowTitle = "Exchange Online"
}
