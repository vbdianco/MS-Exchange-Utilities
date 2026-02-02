$usrCred = Get-Credential
Connect-ExchangeOnline -UserPrincipalName $usrCred.UserName -ShowProgress $true