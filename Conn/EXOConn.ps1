$usrCred = Get-Credential
Connect-ExchangeOnline -UserPrincipalName $usrCred.UserName -ShowProgress $true
$Host.UI.RawUI.WindowTitle = "Exchange Online"