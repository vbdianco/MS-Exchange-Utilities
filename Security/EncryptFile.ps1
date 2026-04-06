$Content = Get-Content "D:\vbdia\Documents\Projects\MS-Exchange-Utilities\Security\cred.txt" -Raw
$SecureContent = ConvertTo-SecureString $Content -AsPlainText -Force
$Encrypted = ConvertFrom-SecureString -SecureString $SecureContent -Key (Get-Content "D:\vbdia\Documents\Projects\MS-Exchange-Utilities\Security\Secret\file.key")
$Encrypted | Out-File "D:\vbdia\Documents\Projects\MS-Exchange-Utilities\Security\cred.txt"