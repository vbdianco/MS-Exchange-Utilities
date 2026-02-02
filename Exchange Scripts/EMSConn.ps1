$cred = Get-Credential
$Session = New-PSSession -ConfigurationName Micrososft.Exchange -ConnectionUri http://OMIFEXCD15001V.int.okadamanila.com/PowerShell -Authentication Kerberos -Credential $cred
Import-PSSession $Session -DisableNameChecking